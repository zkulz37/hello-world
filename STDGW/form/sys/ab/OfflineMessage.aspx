<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Offline Messages</title>
    <script language="javascript" type="text/javascript">
    function BodyInit(){
        datGetMessage.Call("SELECT");
    }
    function OnReply(){
        if(grdMessage.row > 0){
            var user_id     = "<%=Session["User_ID"]%>";
            var receiver_id = grdMessage.GetGridData(grdMessage.row,0);
            var url = System.RootURL + "/form/sys/ab/ChatingDetail.aspx?from_user=" + user_id + "&to_user=" + receiver_id;
            System.OpenModeless(url,500,300, "status:no;resizable:yes");
        }
        
    }
    
    function OnClose(){
        window.close();
    }
    function OnRowSelected(){
        if(grdMessage.row > 0){
            var s = grdMessage.GetGridData(grdMessage.row,0)+"."+grdMessage.GetGridData(grdMessage.row,3)+":"+grdMessage.GetGridData(grdMessage.row,1);
            txtaMessage.SetDataText(s);
        }
    }
    function OnDataReceive(oData){
        if(grdMessage.rows == 1){
            window.close();
        }
        else{
            //window.resizeTo(500,400);
        }
    }
    </script>
</head>
<body>
     <gw:data id="datGetMessage"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3" function="esys.sp_sel_tes_chatting" > 
                <input bind="grdMessage" > 
                    <input bind="txtUserID" /> 
                </input> 
                <output bind="grdMessage" /> 
            </dso> 
        </xml> 
 </gw:data>
 <table width="100%">
    <tr>
        <td>
            <gw:grid   
            id="grdMessage"  
            header="From|Message|To|Date"   
            format="0|0|0|0"  
            aligns="0|0|0|0"  
            defaults="|||"  
            editcol="1|1|1|1"  
            widths="1000|3000|1000|2000"  
            styles="width:100%; height:100"   
            sorting="T"
            onselchange ="OnRowSelected()"   
            />   
        </td>
    </tr>
    <tr>
        <td>
            <gw:textarea id="txtaMessage" styles="width:100%;height:100" />
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%">
                <tr>
                    <td width="94%"></td>
                    <td>
                        <gw:imgBtn id="btnReply" img="select" title="Reply" styles="width:100%" onclick="OnReply()"/>
                    </td>
                    <td>
                        <gw:imgBtn id="btnClose" img="cancel" title="close" styles="width:100%" onclick="OnClose()"/>
                    </td>        
                </tr>
            </table>
        </td>
    </tr>
 </table>
 <gw:textbox id="txtUserID" styles="display:none" text="<%=Session["User_ID"] %>"/>

</body>
</html>
