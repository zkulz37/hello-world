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
        var pk = '<%=request.QueryString("pk")%>';
        var view = '<%=request.QueryString("view")%>';
        txtNewsPK.text = pk;
        txtNewsPK1.text= pk;
        if(view=="N")
            datNewsPro.Call();            
        else
            datNews.Call("SELECT");

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
        if (obj.id=="datNewsPro")
        {
           datNews.Call("SELECT");
        }
    }
    function OnDataError(oData){
    }
</script>
<body>
    <gw:data id="datNewsPro" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="comm.sp_pro_agas00030" > 
                <input>
                    <input bind="txtNewsPK1" />
                </input> 
                <output> 
                     <output bind="txtNewsPK1" />
                </output>
            </dso> 
        </xml> 
    </gw:data>  
    <!------------------------------>
    <gw:data id="datNews" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="2" type="control" function="comm.sp_sel_agas00030_1" > 
                <inout>
                    <inout bind="txtNewsPK" />
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
                                        
                                    </td>
                                    <td style="padding-left:5px">
                                        
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
                                            <td style="padding-left:5px"><gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" text="Cancel" onclick="OnRedirect('agas0030_list.aspx')" /></td>
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
    <gw:textbox id="txtNewsPK1" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtNewsTemp" styles='width:100%;display:none' />
    <gw:textbox id="txtNewsType" maxlen="100" styles='width:100%;display:none' />
    
</body>
</html>
