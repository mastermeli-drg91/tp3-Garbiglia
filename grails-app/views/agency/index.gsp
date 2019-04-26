<%--
  Created by IntelliJ IDEA.
  User: dgarbiglia
  Date: 2019-04-26
  Time: 10:00
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Buscador de agencias</title>
    <meta name="layout" content="main"/>
</head>

<body>
<h1>
    Buscador de agencias
</h1>
<form class="form-horizontal" style="margin:0 auto">
    <div class="form-group">
        <label class="col-lg-4 control-label">Site ID</label>
        <div class="col-lg-4">
            <g:textField id="site_id" name="site_id" required="true" value="MLA"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-lg-4 control-label">Payment Method</label>
        <div class="col-lg-4">
            <g:textField id="payment_method_id" name="payment_method_id" required="true" value="rapipago"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-lg-4 control-label">Latitud, Longitud</label>
        <div class="col-lg-4">
            <g:textField id="lat_long" name="lat_long" required="true" value="-31.412971,-64.18758,300"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-lg-4 control-label">Limit</label>
        <div class="col-lg-4">
            <g:textField id="limit" name="limit"  />
        </div>
    </div>

    <div class="form-group">
        <label class="col-lg-4 control-label">Offset</label>
        <div class="col-lg-4">
            <g:textField id="offset" name="offset"  />

        </div>
    </div>

    <div class="form-group">
        <label class="col-lg-4 control-label">Order By</label>
        <div class="col-lg-4">
            <g:select name="order_by" from="${['distance', 'address_line', 'agency_code']}" required="true"/>
        </div>
    </div>

    <div class="form-group">
        <div class="">
            <input type="button" onclick="getAgencies()"  value="Enviar" />
        </div>
    </div>

</form>


<script type="text/javascript">
    function getAgencies(){
        var lat_long = document.getElementById("lat_long").value;
        var site_id = document.getElementById("site_id").value;
        var payment_method_id = document.getElementById("payment_method_id").value;
        var limit = document.getElementById("limit").value;
        var offset = document.getElementById("offset").value;
        var order_by = document.getElementById("order_by").value;

        var URL = "${createLink(controller: 'Agency', action: 'showAgencies', params: [site_id: ""])}"+site_id+
            "&payment_methods_id="+payment_method_id+"&near_to="+lat_long+"&limit="+limit+"&offset="+offset+"&order_by="+order_by;
        console.log(URL);
        $.ajax({
            url: URL,
            success: function(resp){
                // var cat_head = document.getElementById("category_head");
                // console.log(site);
                console.log(resp.data)
                var val = resp.data
                // cat_head.innerText = resp.name;
                var subcats_element = document.getElementById("data2");
                while(subcats_element.firstChild){
                    subcats_element.removeChild(subcats_element.firstChild);
                }
                var col_div = document.createElement("div");
                col_div.setAttribute("class", "col-md-4");
                var intro = document.createElement("P");
                intro.innerText = "Agencias cercanas: ";
                intro.style = "display: block; font-size: 24px";
                col_div.appendChild(intro)
                val.forEach(function(data){
                    var inicio = document.createElement("P");
                    inicio.innerText = "Agencia: ";
                    var nombre = document.createElement("P");
                    nombre.innerText = data.description;
                    var dire = document.createElement("P");
                    dire.innerText = "Direccion: " + data.address.address_line;
                    var distancia = document.createElement("P");
                    distancia.innerText = "Distancia: " +data.distance;
                    var ciudad = document.createElement("P");
                    ciudad.innerText = "Ciudad: " +data.address.city;
                    var pais = document.createElement("P");
                    pais.innerText = "Pais: " +data.address.country;
                    var agencyCode = document.createElement("P");
                    agencyCode.innerText = "AgencyCode: " +data.agency_code;
                    var texto4 = document.createElement("br");
                    var texto5 = document.createElement("br");

                    inicio.style = "display: block; font-size: 14px";
                    dire.style = "display: block; font-size: 12px";
                    ciudad.style = "display: block; font-size: 10px";
                    pais.style = "display: block; font-size: 10px";
                    distancia.style = "display: block; font-size: 10px";
                    agencyCode.style = "display: block; font-size: 10px";

                    var like = document.createElement("BUTTON");
                    like.innerText = "LIKE";
                    %{--like.onclick = ${like()};--}%

                    var unlike = document.createElement("BUTTON");
                    unlike.innerText = "UNLIKE";
                    // console.log(data.address);
                    // console.log(data.address.address_line);

                    col_div.appendChild(inicio)
                    col_div.appendChild(nombre)
                    col_div.appendChild(dire)
                    col_div.appendChild(ciudad)
                    col_div.appendChild(pais)
                    col_div.appendChild(distancia)
                    col_div.appendChild(agencyCode)
                    col_div.appendChild(like)
                    col_div.appendChild(unlike)
                    col_div.appendChild(texto4)
                    col_div.appendChild(texto5)



                })
                subcats_element.appendChild(col_div)


            }
        })


    };
    function like(){
        console.log("Like")
    };
</script>


<div class="container-fluid">
    %{--    <h2 id="category_head"></h2>--}%
    <div class="row" id="data">
    </div>
    <div class="row" id="data2">
    </div>
</div>



</body>
</html>