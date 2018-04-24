<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("comm")%>
 <script>
    function BodyInit(){      
        datNews.StatusUpdate();
        OnInit();
    }
    function OnInit(){
        System.Translate(document); 
        //txtNewsTemp.text = '<%=Session("USER_NAME") %>';
        txtNewsTemp.text = '0';
        var pk = '<%=request.QueryString("pk")%>';
        //alert('<%=request.QueryString("tp")%>');
        //alert(pk);
        txtNewsPK.text = "0";
        lbCount.text = "1";
        if(pk.length != 0){
            txtNewsPK.text = pk;
            datNews.Call();            
        }
    }
    function OnRedirect(page){
        var lc = location.href;
        var arr = lc.split("/");
        lc = "";
        for(var x=0; x<arr.length-1; x++){
            lc += arr[x] + "/";
        }
        location.href = lc + page;
    }
    function OnSubmit(){

    }
    function OnDataReceive(obj){
        if (obj.id=="datNews"){
           
        }
    }
    function OnDataError(oData){
    }
</script>
<body>
    <gw:data id="datNews" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8" function="comm.sp_sel_agas0020" procedure="comm.sp_upd_agas0020"> 
                <inout>
                    <inout bind="txtNewsPK" />
                    <inout bind="lbCount" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsTemp" />
                    <inout bind="txtNewsType" />
                    <inout bind="lbTitle" />
                    <inout bind="lbContent" />
                    <inout bind="lbWriter" />
                    <inout bind="lbDate" />
                </inout>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------>
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="center" style="padding-top:20px;padding-right:0px">
                <table cellpadding="0" cellspacing="0" width="700px" style="border:1px solid;border-color:#333333">
                    <tr>
                        <td align="left" style="padding: 10px 10px 10px 10px">
                            <table cellpadding="0" cellspacing="0" width="100%" border="0">
                                <tr>
                                    <td valign="middle" align="left" style="padding-left :10px; font-size:18px;border-bottom:1px solid black" colspan="3">
                                       <gw:label id="lbTitle" />
                                    </td>
                                </tr>
                                <tr style="height:18px">
                                    <td valign="middle" align="left" style="padding-left:10px;white-space: nowrap">
                                        Date Post : <gw:label id="lbDate" />
                                    </td>
                                    <td align="right" style="display:inline">
                                        Count view :
                                    </td>
                                    <td style="padding-left:5px">
                                        <gw:label id="lbCount"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="border-bottom:1px solid black;padding-top:15px">
                                        <gw:label id="lbContent" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="padding-top:5px">
                                        <table cellpadding="0" cellspacing="0">
                                            <td style="padding-left:5px"><gw:imgbtn id="btnChange" img="change" alt="Change" text="Change" onclick="OnRedirect('agas0020.aspx?tp=' + '<%=request.QueryString("tp")%>' + '&pk=' + '<%=request.QueryString("pk")%>');" /></td>
                                            <td style="padding-left:5px"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="OnRedirect('agas0020_list.aspx?tp=' + '<%=request.QueryString("tp")%>')" /></td>
                                        </table>
                                    </td>
                                    <td colspan="2" align="right" style="padding-top:5px;padding-right:25px">
                                        <gw:label id="lbWriter" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtNewsPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtNewsTemp" styles='width:100%;display:none' />
    <gw:textbox id="txtNewsType" maxlen="100" styles='width:100%;display:none' />
</body>
</html>
