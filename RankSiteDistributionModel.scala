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

import scala.collection.JavaConversions._
import scala.util.Try

/**
  * Created by IntelliJ IDEA.
  *
  * @author songyang
  *         Tell
  *         Date 2018/12/10
  */
trait RankSiteDistributionModel extends ModelBatchComponent {
  this: Configurable with SparkBatch =>

  override def workflowSetup() = {
    val startDate = getParam[String](ModelBatchComponent.startDate, this)
    val endDate = getParam[String](ModelBatchComponent.endDate, this)
    //load  querylog df
    val dataPath = inputConfig.getString(ModelBatchComponent.inputServerLog)
      .replace(ModelBatchComponent.placeHolder, Tools.dateRangePath(startDate, endDate))
    setDataFrame(Tools.listValidFiles(dataPath), ModelBatchComponent.inputServerLogRDD, this, "parquet")

    val QueryDateset  = getRDD[DataFrame](ModelBatchComponent.inputServerLogRDD, this)
    import QueryDateset.sparkSession.implicits._
    val queryDF = QueryDateset.as[RankQueryProfile]
    queryDF.printSchema()

    val queryLocation = queryDF.filter(_.location_count == 1).persist(StorageLevel.MEMORY_AND_DISK_SER)
    val queryLocation_bigger  = queryDF.filter(_.location_count > 1).persist(StorageLevel.MEMORY_AND_DISK_SER)


    println(startDate)
    println("all query count********************************************")
    println(queryDF.count())

    println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!the overall part is incoming!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")

    println("****************************0000000000000000000000000000000*********************************")
    print_stastic_by_site(0,queryLocation,queryLocation_bigger)
    println("\n\n")
    println("****************************1111111111111111111111111111111*********************************")
    print_stastic_by_site(1,queryLocation,queryLocation_bigger)
    println("\n\n")
    println("****************************2222222222222222222222222222222*********************************")
    print_stastic_by_site(2,queryLocation,queryLocation_bigger)
    println("****************************10101010101010101010101010101010*********************************")
    print_stastic_by_site(10,queryLocation,queryLocation_bigger)

    queryLocation.unpersist()
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

//    println(s"(location_count =10)filter rate#$platform********************************************")
//    queryLocation_bigger.filter(col("location_count").equalTo(10)).selectExpr("ad_num/location_count as filter_rate", "unique_ids_count").groupBy("unique_ids_count").avg("filter_rate")
//      .orderBy("unique_ids_count").collect().foreach(println)
//
//    println(s"(unique_ids_count greater than location_count )location_count filter rate#$platform********************************************")
//    queryLocation_bigger.filter(col("unique_ids_count") >= col("location_count") )
//      .selectExpr("ad_num/location_count as filter_rate","1")
//      .groupBy("1").avg("filter_rate").collect().foreach(println)
//
//    println(s"new aglo rate#$platform********************************************")
//    queryLocation_bigger.filter(col("unique_ids_count") >= col("location_count"))
//      .selectExpr("if(ad_num/location_count=1,1,0) as filter_rate", "1")
//      .groupBy("1").avg("filter_rate").collect().foreach(println)
    println(s"old aglo rate#$platform********************************************")
    queryLocation_bigger.filter(col("unique_ids_count") > col("location_count"))
      .selectExpr("ad_num/location_count as filter_rate", "1")
      .groupBy("1").avg("filter_rate").collect().foreach(println)

    val muti_overall = queryLocation_bigger
      .selectExpr("ad_num/location_count as filter_rate", "1")
      .groupBy("1").avg("filter_rate").head()

    val muti_lesseq = queryLocation_bigger.filter(col("unique_ids_count") <= col("location_count"))
      .selectExpr("ad_num/location_count as filter_rate", "1")
      .groupBy("1").avg("filter_rate").head()

    println(s"[${platform},'mult-location req overall filter rate is',${muti_overall.getDouble(1)}]")
    println(s"[${platform},'mult-location req lesseaq filter rate is',${muti_lesseq.getDouble(1)}]")
//
//
//    println(s"(unique_ids_count greater than location_count ) VERIFY DATA !!!location_count filter rate#$platform********************************************")
//    queryLocation_bigger.filter(col("unique_ids_count") >= col("location_count") )
//      .selectExpr("ad_num/location_count as filter_rate","1")
//      .groupBy("1").avg("filter_rate").collect().foreach(println)
//
//    println(s"(1 location_count)uniqid_count avg #$platform********************************************")
//    queryLocation.filter(col("unique_ids_count").>(1)).select("unique_ids_count").groupBy().avg("unique_ids_count").collect().foreach(println)
//    println(s"(1 location_count)uniqid_count dist #$platform********************************************")
//    queryLocation.filter(col("unique_ids_count").>(1)).select("unique_ids_count").groupBy("unique_ids_count").count().collect().foreach(println)
//
//    println(s"(unique_ids_count smaller than location_count ) VERIFY DATA !!!location_count filter rate#$platform********************************************")
//    queryLocation_bigger.filter(col("unique_ids_count") < col("location_count") )
//      .selectExpr("ad_num/location_count as filter_rate","1")
//      .groupBy("1").avg("filter_rate").collect().foreach(println)

  }


}
