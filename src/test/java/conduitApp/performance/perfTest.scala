package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import com.intuit.karate.gatling.KarateProtocol
import io.gatling.core.Predef._
import io.gatling.core.protocol.Protocol
import io.gatling.core.structure.ScenarioBuilder

class PerfTest extends Simulation {

  // Define Karate protocol
  val protocol: KarateProtocol = karateProtocol(
    "classpath:conduitApp/performance/createArticle.feature" -> Nil
  )

  // Create a scenario
  val createArticleScenario: ScenarioBuilder = scenario("Create Article")
    .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  // Set up the simulation
  setUp(
    createArticleScenario.inject(atOnceUsers(10)).protocols(protocol)
  )
}
