package com.netease.rank.model

import com.netease.rank.component.ModelBatchComponent
import com.netease.rank.config.Configurable
import com.netease.rank.feature.{RankQueryInfoProfile, RankQueryProfile, RankResultProfile}
import com.netease.rank.parse.{RankQueryInfoParse, RankQueryParse, RankResultParse}
import com.netease.rank.spark.SparkBatch
import com.netease.rank.utils.Tools
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.{DataFrame, Dataset}
import org.apache.spark.sql.functions.col
import org.apache.spark.storage.StorageLevel

import scala.util.Try

/**
 * Created by IntelliJ IDEA.
 *
 * @author songyang
 *         Tell
 *         Date 2018/12/10
 */
trait RankQueryOsappvModel extends ModelBatchComponent {
  this: Configurable with SparkBatch =>

  override def workflowSetup() = {
    val startDate = getParam[String](ModelBatchComponent.startDate, this)
    val endDate = getParam[String](ModelBatchComponent.endDate, this)
    val sPath = inputConfig.getString(ModelBatchComponent.inputServerLog)
      .replace(ModelBatchComponent.placeHolder, Tools.dateRangePath(startDate, endDate))
    val validPath = Tools.listValidFiles(sPath, "tmp")
    if (validPath.nonEmpty) {
      setLZORDD(validPath.mkString(","), ModelBatchComponent.inputServerLogRDD, this)
    } else {
      println(s"The $sPath not found in hdfs")
    }

    val serverLog = getRDD[RDD[String]](ModelBatchComponent.inputServerLogRDD, this)

    val rankQuery = RankQueryParse.parse(serverLog, partitionNum)
    val rankQueryInfo = RankQueryInfoParse.parse(serverLog, partitionNum)
    val RankQueryResult = RankResultParse.parse(serverLog, partitionNum)

    val outPutPath = s"${outputConfig.getString("path")}/$endDate/"

    val queryDataSet = hiveContext.createDataFrame[RankQueryProfile](rankQuery)
    import queryDataSet.sparkSession.implicits._
    val queryDF = queryDataSet.repartition(partitionNum, col("rid"), col("platform"), col("category"))
      .as[RankQueryProfile].filter(_.rid.split('_')(0) != "ytrs").persist(StorageLevel.MEMORY_AND_DISK_SER)
    queryDF.printSchema()

    val queryinfoDataSet = hiveContext.createDataFrame[RankQueryInfoProfile](rankQueryInfo)
      .repartition(partitionNum, col("rid"), col("platform"), col("category"))
      .as[RankQueryInfoProfile].persist(StorageLevel.MEMORY_AND_DISK_SER)
    import queryinfoDataSet.sparkSession.implicits._
    queryinfoDataSet.printSchema()

    val queryresultDataSet = hiveContext.createDataFrame[RankResultProfile](RankQueryResult)
    import queryresultDataSet.sparkSession.implicits._
    val queryresultDF = queryresultDataSet.repartition(partitionNum, col("rid"), col("platform"), col("category"))
      .persist(StorageLevel.MEMORY_AND_DISK_SER)
    queryresultDF.printSchema()

    val queryLocation = queryDF.filter(_.location_count == 1).persist(StorageLevel.MEMORY_AND_DISK_SER)

    val OsappvFilter = queryinfoDataSet.join(queryLocation, Seq("rid", "platform", "category"), "right")
      .persist(StorageLevel.MEMORY_AND_DISK_SER)

    val LocationsiteFilter = queryresultDataSet.join(queryLocation, Seq("rid", "platform", "category"), "right")
      .persist(StorageLevel.MEMORY_AND_DISK_SER)

    //OsappvFilter.select("os").groupBy("os").count().write.json(s"$outPutPath/os/")
    //OsappvFilter.select("appv").groupBy("appv").count().write.json(s"$outPutPath/appv/")
    println(startDate)
    println("all query count********************************************")
    println(queryDF.count())

    println("os********************************************")
    OsappvFilter.select("os").groupBy("os").count().collect().foreach(println)
    println("appv********************************************")
    OsappvFilter.select("appv").groupBy("appv").count().collect().foreach(println)

    println("location********************************************")
    LocationsiteFilter.select("location").groupBy("location").count().orderBy("location").collect().foreach(println)

    println("1 size-distribution********************************************")
    LocationsiteFilter.select("size").groupBy("size").count().orderBy("size").collect().foreach(println)

    println("size-average********************************************")
    //LocationsiteFilter.select("location_count","size").groupBy("location_count").avg("size").collect().foreach(println)
    queryLocation.select("location_count","unique_ids_count").groupBy("location_count").avg("unique_ids_count").collect().foreach(println)

    val queryLocation_bigger  = queryDF.filter(_.location_count > 1).persist(StorageLevel.MEMORY_AND_DISK_SER)

    //println("location_ount location check diff ********************************************")
    val LocationbiggersiteFilter = queryresultDataSet.join(queryLocation_bigger, Seq("rid", "platform", "category"), "right")
      .persist(StorageLevel.MEMORY_AND_DISK_SER)
    //LocationbiggersiteFilter.select("location_count","location", "size").distinct().groupBy("location_count","location").avg("size")
    //  .orderBy("location_count","location").collect().foreach(println)

    println("location_ount unique_ids_count average********************************************")
    LocationbiggersiteFilter.select("location_count","unique_ids_count").groupBy("location_count").avg("unique_ids_count")
      .orderBy("location_count").collect().foreach(println)

    println("rid unique_ids_count distribution********************************************")
    LocationbiggersiteFilter.select("rid","unique_ids_count").groupBy("unique_ids_count").count()
      .orderBy("unique_ids_count").collect().foreach(println)

    println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!the overall part is incoming!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")


    println("****************************0000000000000000000000000000000*********************************")
    print_stastic_by_site(0,queryLocation,queryLocation_bigger)
    println("\n\n")
    println("****************************1111111111111111111111111111111*********************************")
    print_stastic_by_site(1,queryLocation,queryLocation_bigger)
    println("\n\n")
    println("****************************2222222222222222222222222222222*********************************")
    print_stastic_by_site(2,queryLocation,queryLocation_bigger)

    println("crt we do , avg")
    queryDF.filter(col("unique_ids_count") > col("location_count")).select("unique_ids_count").groupBy().avg("unique_ids_count").collect().foreach(println)
    println("ctr we do ,dist")
    queryDF.filter(col("unique_ids_count") > col("location_count")).select("unique_ids_count").groupBy("unique_ids_count").count().collect().foreach(println)

    println("haiqiang check loacationid********************************************")
    //LocationsiteFilter.filter(col("location").isin(List(4,50,75,33,31,32,34,35,36,37,38,131,20,1))).select("location","platform" , "category").distinct().orderBy("location").collect().foreach(println)
    //LocationsiteFilter.select("location","platform" , "category").distinct().orderBy("location").collect().foreach(println)
    LocationsiteFilter.select("location","platform" , "category").groupBy("location","platform" , "category").count().orderBy("location","platform" , "category").collect().foreach(println)

    queryLocation.unpersist()
    OsappvFilter.unpersist()
    queryinfoDataSet.unpersist()
    queryDF.unpersist()
    queryLocation_bigger.unpersist()
  }
  def print_stastic_by_site(platform: Int,filterDateOne:Dataset[RankQueryProfile],filterDateMore:Dataset[RankQueryProfile]) = {
    var queryLocation = filterDateOne
    var queryLocation_bigger = filterDateMore
    if(platform != 0) {
      queryLocation = filterDateOne.filter(col("platform").equalTo(platform)).persist(StorageLevel.MEMORY_AND_DISK_SER)
      queryLocation_bigger = filterDateMore.filter(col("platform").equalTo(platform)).persist(StorageLevel.MEMORY_AND_DISK_SER)
    }
    else {
      queryLocation = filterDateOne
      queryLocation_bigger = filterDateMore
    }
    println(s"(1 location_count) all #$platform********************************************")
    println( queryLocation.count())

    println(s"(1 location_count)uniqid_count is 1#$platform********************************************")
    println(queryLocation.filter(col("unique_ids_count").equalTo(1)).count())

    println(s"(1 location_count)uniqid_count #$platform********************************************")
    println( queryLocation.filter(col("unique_ids_count").>(1)).count())

    println(s"(more location_count)uniqid_count is 1#$platform********************************************")
    println(queryLocation_bigger.filter(col("unique_ids_count") < col("location_count")).filter(col("unique_ids_count").equalTo(1)).count())

    println(s"(more location_count)uniqid_count less than location_count#$platform********************************************")
    println( queryLocation_bigger.filter(col("unique_ids_count") < col("location_count")).count())

    println(s"(more location_count)uniqid_count equal to location_count#$platform********************************************")
    println(queryLocation_bigger.filter(col("unique_ids_count").equalTo(col("location_count")) ).count())

    println(s"(more location_count)uniqid_count more than location_count#$platform********************************************")
    println(queryLocation_bigger.filter(col("unique_ids_count") > col("location_count")).count())

    println(s"(more location_count)uniqid_count 2 times than  location_count#$platform********************************************")
    println(queryLocation_bigger.filter(col("unique_ids_count") > col("location_count").*(2)).count())

    println(s"(location_count =10)filter rate#$platform********************************************")
    queryLocation_bigger.filter(col("location_count").equalTo(10)).selectExpr("ad_num/location_count as filter_rate", "unique_ids_count").groupBy("unique_ids_count").avg("filter_rate")
      .orderBy("unique_ids_count").collect().foreach(println)

    println(s"(unique_ids_count greater than location_count )location_count filter rate#$platform********************************************")
    queryLocation_bigger.filter(col("unique_ids_count") >= col("location_count") )
      .selectExpr("ad_num/location_count as filter_rate","1")
      .groupBy("1").avg("filter_rate").collect().foreach(println)

    println(s"new aglo rate#$platform********************************************")
    queryLocation_bigger.filter(col("unique_ids_count") >= col("location_count"))
    .selectExpr("if(ad_num/location_count=1,1,0) as filter_rate", "1")
    .groupBy("1").avg("filter_rate").collect().foreach(println)
    println(s"old aglo rate#$platform********************************************")
    queryLocation_bigger.filter(col("unique_ids_count") >= col("location_count"))
    .selectExpr("ad_num/location_count as filter_rate", "1")
    .groupBy("1").avg("filter_rate").collect().foreach(println)


    println(s"(unique_ids_count greater than location_count ) VERIFY DATA !!!location_count filter rate#$platform********************************************")
    queryLocation_bigger.filter(col("unique_ids_count") >= col("location_count") )
      .selectExpr("ad_num/location_count as filter_rate","1")
      .groupBy("1").avg("filter_rate").collect().foreach(println)

    println(s"(1 location_count)uniqid_count avg #$platform********************************************")
    queryLocation.filter(col("unique_ids_count").>(1)).select("unique_ids_count").groupBy().avg("unique_ids_count").collect().foreach(println)
    println(s"(1 location_count)uniqid_count dist #$platform********************************************")
    queryLocation.filter(col("unique_ids_count").>(1)).select("unique_ids_count").groupBy("unique_ids_count").count().collect().foreach(println)

    println(s"(unique_ids_count smaller than location_count ) VERIFY DATA !!!location_count filter rate#$platform********************************************")
    queryLocation_bigger.filter(col("unique_ids_count") < col("location_count") )
      .selectExpr("ad_num/location_count as filter_rate","1")
      .groupBy("1").avg("filter_rate").collect().foreach(println)

  }


}
