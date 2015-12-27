function connAndAuth(username, password, statusCallback) {
    var url = "http://176.31.182.158:3001/auth/local";
    var httpReq = new XMLHttpRequest();
    httpReq.onreadystatechange = function() {
        if(httpReq.readyState == 4) {
            console.log(httpReq.status);
            console.log(httpReq.responseText);
            if(httpReq.status == 200)
                statusCallback("Authorization successfull");
            else if(httpReq.status == 404)
                statusCallback("Failed to connect");
            else if(httpReq.status == 403)
                statusCallback("Username/password not correct");
        }
    }
    var jsonData = {
        "identifier": username,
        "password": password
    };
    httpReq.open("POST", url, true);
    httpReq.setRequestHeader("Content-type", "application/json");
    httpReq.send(JSON.stringify(jsonData));

}
