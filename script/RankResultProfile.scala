package com.netease.rank.feature

import org.json4s.DefaultFormats
import org.json4s.jackson.Serialization

/**
 * Created by IntelliJ IDEA.
 *
 * @author Lilonghua
 *         Tell 15810702615
 *         Date 2018/5/24
 */
case class RankResultProfile(
  rid: String,
  platform: String,
  category: String,
  exp_name: String,
  location: String,
  scheduling_id: String,
  account_id: String,
  idea_id: String,
  idea_type: String,
  bid: Double,
  ctr: Double,
  rank_ctr: Double,
  orig_ctr: Double,
  ecpm: Double,
  rank_ecpm: Double,
  ecpm2_idea_id: Long,
  ecpm2: Double,
  flag: Int,
  random: Double,
  win_price: Double,
  new_win_price: Double,
  w: Double,
  pw: Double,
  lw: Double,
  factor_wp_ratio: Double,
  wp_ratio: Double,
  new_wp_ratio: Double,
  cvr: Double,
  size: Int,
  ptr_flag: Int,
  ptr: Double,
  ext: scala.collection.Map[String, String],
  host: String,
  time: Long) extends Specializable {

  def getUniqueKey: String = s"$rid,$location,$idea_id"
  def key: String = s"$getUniqueKey,$time"

  override def toString: String = {
    implicit val formats = DefaultFormats
    Serialization.write(Map(
      "rid" -> rid,
      "platform" -> platform,
      "category" -> category,
      "exp_name" -> exp_name,
      "location" -> location,
      "scheduling_id" -> scheduling_id,
      "account_id" -> account_id,
      "idea_id" -> idea_id,
      "idea_type" -> idea_type,
      "bid" -> bid,
      "ctr" -> ctr,
      "rank_ctr" -> rank_ctr,
      "orig_ctr" -> orig_ctr,
      "ecpm" -> ecpm,
      "rank_ecpm" -> rank_ecpm,
      "ecpm2_idea_id" -> ecpm2_idea_id,
      "ecpm2" -> ecpm2,
      "flag" -> flag,
      "random" -> random,
      "win_price" -> win_price,
      "new_win_price" -> new_win_price,
      "w" -> w,
      "pw" -> pw,
      "lw" -> lw,
      "factor_wp_ratio" -> factor_wp_ratio,
      "wp_ratio" -> wp_ratio,
      "new_wp_ratio" -> new_wp_ratio,
      "cvr" -> cvr,
      "size" -> size,
      "ptr_flag" -> ptr_flag,
      "ptr" -> ptr,
      "ext" -> ext,
      "host" -> host,
      "time" -> time))
  }
}