package com.netease.rank.model

import com.netease.rank.component.ModelBatchComponent
import com.netease.rank.config.Configurable
import com.netease.rank.feature.RankResultProfile
import com.netease.rank.spark.SparkBatch
import com.netease.rank.utils.Tools
import org.apache.spark.sql.functions.{col, count, sum}
import org.apache.spark.sql.{DataFrame, Dataset}
import org.apache.spark.storage.StorageLevel

import scala.util.Try
import scala.collection.JavaConversions._

/**
  * Created by IntelliJ IDEA.
  *
  * @author songyang
  *         Tell
  *         Date 2018/12/10
  */
trait PtrComputeModel extends ModelBatchComponent {
  this: Configurable with SparkBatch =>


  override def preStart() = {
    super.preStart()
    val startDate = getParam[String](ModelBatchComponent.startDate, this)
    val endDate = getParam[String](ModelBatchComponent.endDate, this)

    val resultDataPath = inputConfig.getString(ModelBatchComponent.inputServerLog)
      .replace(ModelBatchComponent.placeHolder, Tools.dateRangePath(startDate, endDate))
    setDataFrame(Tools.listValidFiles(resultDataPath), ModelBatchComponent.inputServerLogRDD, this, "parquet")

    val showSql = inputConfig.getString(ModelBatchComponent.inputEventShow)
      .replace(ModelBatchComponent.startDateTag, startDate)
      .replace(ModelBatchComponent.endDateTag, endDate)
    setDataFrame(showSql, ModelBatchComponent.inputEventShowRDD, this)
  }
  override def workflowSetup() = {
    val startDate = getParam[String](ModelBatchComponent.startDate, this)
    val endDate = getParam[String](ModelBatchComponent.endDate, this)

    //******* call statistic group by stie
    val planId = Try(inputConfig.getStringList("planId").toList).getOrElse(Nil)
    println(planId)
    val QueryDateset  = getRDD[DataFrame](ModelBatchComponent.inputServerLogRDD, this)
    val queryTableName: String = "algo_query_raw_data"
    import QueryDateset.sparkSession.implicits._

    QueryDateset.as[RankResultProfile].filter("ext.ptr_flag = '8'")
      .selectExpr("rid", "platform", "category", "location", "ext.ptr as ptr", "time")
      .createOrReplaceTempView(queryTableName)
//      QueryDateset.as[RankResultProfile].filter("ext.ptr_flag = '8'")
//        .selectExpr("rid", "platform", "category", "location", "ext.ptr as ptr", "time","ext.ptr_flag")
//        .head(1000).foreach(println)
    println("all planid")
    hiveContext.sql(
      s"""
         |SELECT
         |        *
         |FROM
         |(
         |        SELECT
         |              a.format_time,
         |              avg(a.ptr)
         |        FROM
         |        (
         |              SELECT
         |                    substring(from_unixtime(cast(substring(time, 1, 10) as bigint), 'HH:mm'),1,4) as format_time,
         |                    ptr
         |              FROM
         |                    $queryTableName
         |              WHERE SUBSTRING(ptr,1,1) != '1'
         |        )a
         |        group by a.format_time
         |)b
         |ORDER BY b.format_time
       """.stripMargin
    ).collect().foreach(println)
    println("all planid end")
    for(planid <- planId){
    val showtableDF = getRDD[DataFrame](ModelBatchComponent.inputEventShowRDD, this)
      .selectExpr("request_id as rid","site as platform","category","location","adplan_id")
      .filter(col("adplan_id").equalTo(planid))
    println(s"planid count in show table is ${showtableDF.count()}")
    println(s"The filter planid is $planid")
    QueryDateset.as[RankResultProfile].filter("ext.ptr_flag = '8'")
      .selectExpr("rid", "platform", "category", "location", "ext.ptr as ptr", "time")
      .join(showtableDF,Seq("rid", "platform", "category", "location"),"inner")
      .createOrReplaceTempView(queryTableName)

    hiveContext.sql(
      s"""
         |SELECT
         |        *
         |FROM
         |(
         |        SELECT
         |              a.format_time,
         |              avg(a.ptr)
         |        FROM
         |        (
         |              SELECT
         |                    substring(from_unixtime(cast(substring(time, 1, 10) as bigint), 'HH:mm'),1,4) as format_time,
         |                    ptr
         |              FROM
         |                    $queryTableName
         |              WHERE SUBSTRING(ptr,1,1) != '1'
         |        )a
         |        group by a.format_time
         |)b
         |ORDER BY b.format_time
       """.stripMargin
    ).collect().foreach(println)
      }

  }


}
