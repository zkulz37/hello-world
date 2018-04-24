<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head>
    <title><%=Request.QueryString("to_user")%>&nbsp;--&nbsp;Instant Message</title>
    <script language="javascript" type="text/javascript">
    function KeyHandler() {
        var key;
        var frame = document.getElementById('ifrSendMessage').contentWindow;
        key = frame.event.keyCode;
        //alert(key);
        if(key == 13)  
		    return OnSend() ;
	    return true;
    }
    window.onresize = OnResizeWin;
    function OnResizeWin(){
        var height = getHeight();
        var width = getWidth();
        frameDoc = document.getElementById("ifrMessage").contentWindow.document;
        //frameDoc.body.innerText = "width="+width+" height="+height;
        frame1 = document.getElementById("ifrMessage");
        frame2 = document.getElementById("ifrSendMessage");
        frame1.height = height - 100;
        frame1.width = width - 50;
        frame2.width = width - 50;
    }
    function getHeight(){
     var height;
     /*Mozila IE 7, IE 6, OldIE*/
     if (typeof window.innerHeight != 'undefined')
        height = window.innerHeight;
     else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientHeight != 'undefined' && document.documentElement.clientHeight != 0)
       height = document.documentElement.clientHeight;
     else height = document.getElementsByTagName('body')[0].clientHeight;
     return height;
}
function getWidth(){
     var width;
     /*Mozila IE 7, IE 6, OldIE*/
     if (typeof window.innerWidth != 'undefined')
        width = window.innerWidth;
     else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth != 'undefined' && document.documentElement.clientWidth != 0)
       width = document.documentElement.clientWidth;
     else width = document.getElementsByTagName('body')[0].clientWidth;
     return width;
}
    function BodyInit(){
        window.frames["ifrSendMessage"].document.body.contentEditable = true;
        window.frames["ifrMessage"].document.body.contentEditable = true;
        document.getElementById('ifrSendMessage').contentWindow.document.onkeypress = KeyHandler;
        window.frames["ifrSendMessage"].focus();
        txtSenderID.text = "<%=Request.QueryString("from_user") %>";
        txtReceiverID.text = "<%=Request.QueryString("to_user") %>";
        //window.frames["ifrSendMessage"].document.bgColor="#c0c0c0";
        if(txtSenderID.text == "" || txtReceiverID.text == ""){
            alert("Invalid sender id or receiver id.");
            window.close();
        }
        GetMessage();
    }

    function GetMessage(){
        datGetMessage.Call("SELECT");
        window.setTimeout("GetMessage()",10000);
    }
    function OnDataReceive(oData){
        if(oData.id == "datGetMessage"){
            for(var i=1;i<grdMessage.rows;i++){
                if(grdMessage.GetGridData(i,0) != ""){
                    
                    var message = grdMessage.GetGridData(i,1);
                    var sender ="<b style='color:Black'>"+ grdMessage.GetGridData(i,0) +"</b>:&nbsp;";
                    var s = sender + "<b style='color:Black'>" + Format(message) + "</b>";
                    
                    AddMessage(s);    
                }
            }
            if(grdMessage.rows > 1){
                lblStatus.text = grdMessage.GetGridData(grdMessage.rows-1,4);
            }
        }
        else if(oData.id == "datSendMessage"){
            clearTextSend();
            txtaSendMessage.SetDataText("");
            txtaSendMessage.SetEnable(true);
            btnSend.SetEnable(true);
        }
    }
    var url_smiley = "<img src ='" +System.RootURL + "/images/smileys/";
    var maxIcon = 108;
    var iconCode = "";
    function Format(message){
        var url_img = url_smiley;
        for(var i=0;i<maxIcon;i++){
            url_img += i + ".gif' title='[ "+ i +" ]' />";
            iconCode = "["+ i +"]"
            while(message.indexOf(iconCode) != -1){
                message = message.replace(iconCode,url_img);
            }
            url_img = url_smiley;
        }   
        
        return Trim(message);
    }
    function AddMessage(message){
        ifrMessage.document.body.innerHTML=ifrMessage.document.body.innerHTML + message + "<br>";
        ifrMessage.scroll(0,ifrMessage.document.body.scrollHeight);
    }
    function clearTextSend(){
        ifrSendMessage.document.execCommand("SelectAll");
        ifrSendMessage.document.execCommand("Cut");
    }
    function OnSend(){
        var msg = Trim(ifrSendMessage.document.body.innerText);
        
        if(msg == "") return;
        
        txtaSendMessage.SetDataText(msg);
        var sender ="<b style='color:Blue'>"+ txtSenderID.text +"</b>:&nbsp;";
        var s = sender + "<b style='color:Blue'>" + Format(msg) + "</b>";
        
        AddMessage(s);
        
        clearTextSend();
       
        txtaSendMessage.SetEnable(false);
        btnSend.SetEnable(false);
        datSendMessage.Call();
    }
    function OnClose(){
      
        var aTemp = new Array();
      
        for(var i=0;i<System.S_ArrUserChat.length;i++){
            if(txtReceiverID.text != System.S_ArrUserChat[i]){
                aTemp[aTemp.length] = System.S_ArrUserChat[i];
            }
        }
        for(var i=0;i<System.S_ArrUserChat.length;i++){
             System.S_ArrUserChat[i]="";
        }
        
        for(var i=0;i<aTemp.length;i++){
             System.S_ArrUserChat[i]=aTemp[i];
        }
        //alert(System.S_ArrUserChat);
    }
</script>
</head>
<body onunload="OnClose()">
<gw:data id="datGetMessage"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4" function="esys.sp_sel_tes_chatting_one_one" > 
                <input bind="grdMessage" > 
                    <input bind="txtSenderID" /> 
                    <input bind="txtReceiverID" />
                </input> 
                <output bind="grdMessage" /> 
            </dso> 
        </xml> 
 </gw:data>
 <gw:data id="datSendMessage"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process" parameter="0,1,2" procedure="esys.sp_upd_tes_chatting" > 
                <input> 
                    <input bind="txtSenderID" /> 
                    <input bind="txtReceiverID" />
                    <input bind="txtaSendMessage" />
                </input> 
                <output> 
                    <output bind="txtSendStatus" />
                </output>
            </dso> 
        </xml> 
 </gw:data>
 
<table width="100%">
    <tr>
        <td colspan="2">
            Status:
            <gw:label id="lblStatus" styles="width:90%" />  
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <iframe id="ifrMessage" width="400" height="200" style="" scrolling="auto" ></iframe>
        </td>
    </tr>
    <tr>
        <td>
            <gw:textarea id="txtaSendMessage" styles="width:100%;height:50;display:none" />
            <iframe id="ifrSendMessage" width="400" height="70" style="line-height:100" scrolling="no" ></iframe>
        </td>
        <td width="5%">
            <gw:icon id="btnSend" text="Send" onclick="OnSend()"/>
        </td>
    </tr>
</table>
<gw:grid   
    id="grdMessage"  
    header="From|Message|To|Date|Status"   
    format="0|0|0|0|0"  
    aligns="0|0|0|0|0"  
    defaults="||||"  
    editcol="1|1|1|1|1"  
    widths="0|0|0|0|0"  
    styles="width:100%; height:100;display:none"   
    sorting="F"   
    /> 
    <gw:textbox id="txtSendStatus"  styles="display:none" />
    <gw:textbox id="txtSenderID"  styles="display:none" />
    <gw:textbox id="txtReceiverID"  styles="display:none" />
    
</body>
</html>
