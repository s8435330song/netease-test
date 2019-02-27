package com.netease.rank.parse

import com.netease.rank.feature.RankResultProfile
import com.netease.rank.utils.{ BalancePartitioner, JsonUtil }
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.{ DataFrame, SparkSession }

import scala.util.{ Failure, Success, Try }

/**
 * Created by IntelliJ IDEA.
 *
 * @author Lilonghua
 *         Tell 15810702615
 *         Date 2018/5/24
 */
object RankResultParse {

  def parse(rawData: RDD[String], partitionNu: Int = 1000): RDD[RankResultProfile] = {
    rawData.mapPartitions(part => {
      val flatKeys = Array("rid", "platform", "category", "exp_name", "location", "scheduling_id", "account_id",
        "idea_id", "idea_type", "bid", "ctr", "rank_ctr", "orig_ctr", "ecpm", "rank_ecpm", "ecpm2_idea_id", "ecpm2",
        "flag", "random", "win_price", "new_win_price", "w", "pw", "lw", "factor_wp_ratio", "wp_ratio",
        "new_wp_ratio", "cvr","size","ptr_flag","ptr")
      part.flatMap(parseLine(_, flatKeys))
    })
      .map(f => (f.key, f))
      .reduceByKey(new BalancePartitioner(partitionNu), (l, _) => l)
      .map(_._2)
  }

  def parseRow(rawData: RDD[String], spark: SparkSession, partitionNu: Int = 1000): DataFrame = {
    val parseData = rawData.mapPartitions(part => {
      val flatKeys = Array("rid", "platform", "category", "exp_name", "location", "scheduling_id", "account_id",
        "idea_id", "idea_type", "bid", "ctr", "rank_ctr", "orig_ctr", "ecpm", "rank_ecpm", "ecpm2_idea_id", "ecpm2",
        "flag", "random", "win_price", "new_win_price", "w", "pw", "lw", "factor_wp_ratio", "wp_ratio",
        "new_wp_ratio", "cvr","size","ptr_flag","ptr")
      part.flatMap(parseLine(_, flatKeys))
    })
    spark.createDataFrame[RankResultProfile](parseData)

    /*.map(f => (f.key, f))
      .reduceByKey(new BalancePartitioner(partitionNu), (l, _) => l)
      .map(_._2)*/
  }

  def parseLine(line: String, keys: Array[String]): Option[RankResultProfile] = {
    Try(JsonUtil.convertToJValue(line)) match {
      case Success(str) =>
        val body = JsonUtil.getStr(str, "body")
        val time = JsonUtil.getNumber(str, "timestamp")
        val host = JsonUtil.getObjStr(str, "fields", "HOSTNAME")
        if (body.contains("[QUERY_RESULT]") || body.contains("[EMPTY_QUERY_RESULT]")) {
          val f = body.split("\\s").map(_.split(":")).filter(_.length == 2).map(t => (t.head, t.last)).toMap[String, String]
          val result = RankResultProfile(f.getOrElse("rid", ""), f.getOrElse("platform", ""), f.getOrElse("category", ""),
            f.getOrElse("exp_name", ""), f.getOrElse("location", ""), f.getOrElse("scheduling_id", ""),
            f.getOrElse("account_id", ""), f.getOrElse("idea_id", ""), f.getOrElse("idea_type", ""),
            Try(f.getOrElse("bid", "-1").toDouble).getOrElse(-1d), Try(f.getOrElse("ctr", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("rank_ctr", "-1").toDouble).getOrElse(-1d), Try(f.getOrElse("orig_ctr", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("ecpm", "-1").toDouble).getOrElse(-1d), Try(f.getOrElse("rank_ecpm", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("ecpm2_idea_id", "-1").toLong).getOrElse(-1l), Try(f.getOrElse("ecpm2", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("flag", "-1").toInt).getOrElse(-1), Try(f.getOrElse("random", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("win_price", "-1").toDouble).getOrElse(-1d), Try(f.getOrElse("new_win_price", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("w", "-1").toDouble).getOrElse(-1d), Try(f.getOrElse("pw", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("lw", "-1").toDouble).getOrElse(-1d), Try(f.getOrElse("factor_wp_ratio", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("wp_ratio", "-1").toDouble).getOrElse(-1d), Try(f.getOrElse("new_wp_ratio", "-1").toDouble).getOrElse(-1d),
            Try(f.getOrElse("cvr", "0.0").toDouble).getOrElse(-1d),Try(f.getOrElse("size", "-1").toInt).getOrElse(-1),
            Try(f.getOrElse("ptr_flag", "-1").toInt).getOrElse(-1), Try(f.getOrElse("ptr", "0.0").toDouble).getOrElse(-1d),
            f.filterKeys(!keys.contains(_)), host, time)

          if (result.rid.nonEmpty) {
            Some(result)
          } else {
            None
          }
        } else {
          None
        }
      case Failure(ex) =>
        println(s"This feature log $line has'nt feature \t${ex.getMessage}")
        None
    }
  }

}