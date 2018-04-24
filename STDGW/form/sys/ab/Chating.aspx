<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head>

<script language="javascript" type="text/javascript">
function BodyInit()
{
    OnSearch();
} 
function Run() {
    var ws = new ActiveXObject("WScript.Shell");
    try
    {
        ws.run("file:///C:/Program%20Files/TeamViewer3/TeamViewer.exe");
    }
    catch(err)
    {
        if(confirm("You have not install Team viewer. Do you want to download and install it?"))
        {
            window.open(System.RootURL + "/system/activex/TeamViewer_Setup.zip");
        }
    }
}

function OnSearch()
{
    Data_Chating_1.Call("SELECT");
    window.setTimeout("OnSearch()",5*60000);
}

function OnOpen()
{
    var user_id     = "<%=Session["User_ID"]%>";
    var receiver_id = grdEmp.GetGridData(grdEmp.row, 1);
    
    var url = System.RootURL + "/form/sys/ab/ChatingDetail.aspx?from_user=" + user_id + "&to_user=" + receiver_id;
    
    if(!IsOpenWindow(receiver_id)){
        System.S_ArrUserChat[System.S_ArrUserChat.length] = receiver_id;
        System.OpenModeless(url,500,350, "status:no;resizable:yes");
    }
    else{
        alert("You already open chatting dialog  with user "+ receiver_id +".");
    }
}
function IsOpenWindow(from_user){
    for(var i=0;i<System.S_ArrUserChat.length;i++){
        if(System.S_ArrUserChat[i] == from_user){
            return true;
        }
    }
    return false;
}
function GetInstantMessage(){
    datGetMessage.Call("SELECT");
    //window.setTimeout("GetInstantMessage()",2*60000);
}
function OnDataReceive(p_oData){
    if(p_oData.id == "Data_Chating_1"){
        for(var i=1;i<grdEmp.rows;i++){
            if(grdEmp.GetGridData(i,4) == "Online"){
                grdEmp.SetCellBgColor(i,0,i,4,0xFF00BE);
            }
            else{
                grdEmp.SetCellBgColor(i,0,i,4,0xFEBCBE);
            }
        }
        GetInstantMessage();
    }
    else if(p_oData.id == "datGetMessage"){
        for(var i=1; i <  grdMessage.rows ; i++){
            var from_user = grdMessage.GetGridData(i,0);
            if(!IsOpenWindow(from_user)){
                System.S_ArrUserChat[System.S_ArrUserChat.length] = from_user;
                var user_id     = "<%=Session["User_ID"]%>";
                var url = System.RootURL + "/form/sys/ab/ChatingDetail.aspx?from_user=" + user_id + "&to_user=" + from_user;
                
                System.OpenModeless(url,500,300, "status:no;resizable:yes");
            }
        }
     }
}
</script>

    <title></title>
</head>
<body>
<gw:data id="datGetMessage"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3" function="esys.sp_sel_tes_chatting_check" > 
                <input bind="grdMessage" > 
                    <input bind="txtUserID" /> 
                </input> 
                <output bind="grdMessage" /> 
            </dso> 
        </xml> 
 </gw:data>
 <gw:data id="Data_Chating_1" onreceive="OnDataReceive(this)">
    <xml>
        <dso type="grid" function="esys.sp_sel_emp_chat">
            <input bind="grdEmp">
                <input bind="txtEmpID" />
                <input bind="txtEmpName" />
            </input>
            <output bind="grdEmp" />
        </dso>
    </xml>
</gw:data>
                    
<table width="100%">
    <tr>
        <td style="width: 100%">
            <table>
                <tr>
                    <td>
                        Employee ID
                    </td>
                    <td>
                        <gw:textbox id="txtEmpID" onenterkey="OnSearch()"/>
                    </td>
                    <td>
                        Employee Name
                    </td>
                    <td>
                        <gw:textbox id="txtEmpName" onenterkey="OnSearch()"/>
                    </td>                            
                    <td>
                        <gw:imgbtn img="search" alt="Search Employee" onclick="OnSearch()" />
                    </td>     
                    <td>
                        <gw:imgbtn img="auto" alt="Open Team viewer for chatting and PC remote control" onclick="Run()" />
                    </td>                       
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            
            <gw:grid id="grdEmp" header="_PK|User ID|Name|Foreign Name|Status" format="0|0|0|0|0" aligns="0|0|0|0|0" defaults="||||"
                editcol="0|0|0|0|0" widths="0|2000|4000|7500|200" styles="width:100%; height:460" sorting="T"
                oncelldblclick="OnOpen()" />
        </td>
    </tr>
</table>
<gw:grid   
    id="grdMessage"  
    header="From|Message|To|Date"   
    format="0|0|0|0"  
    aligns="0|0|0|0"  
    defaults="|||"  
    editcol="1|1|1|1"  
    widths="0|0|0|0"  
    styles="width:100%; height:20; display:none"   
    sorting="F"   
    />    
    <gw:textbox id="txtUserID" styles="display:none" text="<%=Session["User_ID"] %>"/>
</body>
</html>
