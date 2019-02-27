import org.json4s.jackson.JsonMethods.{ compact, parse }
import scala.io.Source
val kk = Source.fromFile("kk")
val skk = kk.mkString
val bb = parse(skk)
val dd = (bb \ "body").toString.split("INFO]")(1)






val lines = sc.parallelize(List("1 2","1 3","2 3","2 4","1 6","2 9")
val pairs = lines.map(x =>(x.split(" ")(0),x.split(" ")(1)))
pairs.reduceByKey((x,y) => x+"lllll").collectAsMap()
pairs.reduceByKey((x,_) => x).collectAsMap()
airs.reduceByKey((x,_) => x).map(_._2).collect()
