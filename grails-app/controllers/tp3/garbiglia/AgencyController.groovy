package tp3.garbiglia

import grails.converters.JSON
import groovy.json.JsonSlurper

class AgencyController {

    def index() {

        def url = new URL("https://api.mercadolibre.com/sites/")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")

        JsonSlurper json = new JsonSlurper()
        def result = json.parse(connection.getInputStream())
        [result : result]
    }

    def showAgencies(){
        def site = params.site_id
        def payment_methods_id = params.payment_methods_id
        def near_to = params.near_to
        def order_by = params.order_by
        def limit = params.limit
        def offset = params.offset
        def url = new URL("http://localhost:4567/agencies?site_id=$site&payment_methods_id=$payment_methods_id&near_to=$near_to&offset=$offset&limit=$limit&order_by=$order_by")
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept","application/json")
        connection.setRequestProperty("User-Agent","Mozilla/5.0")

        JsonSlurper json = new JsonSlurper()
        def result = json.parse(connection.getInputStream())
        render result as JSON


    }
}
