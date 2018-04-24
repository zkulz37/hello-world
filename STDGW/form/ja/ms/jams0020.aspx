<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("crm")%>
<head id="Head1" runat="server">
    <title>Member List</title>
</head>
<script type="text/javascript" language="javascript">
	var G1_pk           = 0,    
	    G1_member_id    = 1,
	    G1_member_name  = 2,
	    G1_birthday     = 3,
	    G1_address      = 4,
	    G1_country      = 5,
	    G1_telephone    = 6,
	    G1_mobiphone    = 7,
	    G1_email        = 8,
	    G1_red_date     = 9,
	    G1_tcm_photo_pk = 10;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
	dataMemberType    = "<%=ESysLib.SetListDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and Type =10")%>|ALL|Select All";
	lstMemberType.SetDataText(dataMemberType);
	lstMemberType.value = "ALL";
	OnSearch();
}
//------------------------------------------------------------------------
function OnDataReceive(iObj)
{
	switch(iObj.id)
	{
	    case "dsoMemberList":
		    lblTotal.text = idGridList.rows-1;
		    ViewMemberList();
	    break;
	}
}
//------------------------------------------------------------------------
function OnSearch()
{
	dsoMemberList.Call("SELECT");
}
//------------------------------------------------------------------------
 function ViewMemberList()
 {
    var tableView = document.all("viewImg"); 
    var str = "";
    
    tableView.innerHTML = "";
    var trl = idGridList.GetGridControl();	 
    if ( trl.Rows > 1 )
    {
        str = " <table style=' width: 100%;height: 100%' border='0'> "
         
        for(var i =1; i<trl.Rows; i=i+2)
        {
        str =  str + " <tr style='height: 5' > "
        str =  str + "     <td width='49%' style='background-color: #99ccff'>"
        str =  str + "     </td>"     
        str =  str + "     <td width='2%'> "
        str =  str + "     </td>"
        str =  str + "     <td width='49%' style='background-color: #99ccff'> "
        str =  str + "     </td>"    
        str =  str + " </tr> "
        
        str =  str + " <tr style='height: 1%' > "
        str =  str + "     <td width='49%'> "
        
        str = str +" <table style=' width: 100%;height: 100%' border='1'> "
       
            str =  str + " <tr style='height: 1%' > "
            str =  str + "     <td width='20%'> "
            str =  str + "        <img width=100 height=90  src='../../../system/binary/ViewFile.aspx?img_pk=" + idGridList.GetGridData( i, G1_tcm_photo_pk)+ "&table_name=CRM.TGM_MEMBERPHOTO' /> "
            str =  str + "     </td> "
            str =  str + "    <td width='70%'>"
            str =  str + "        <table style='height: 100%; width: 100%' border='0'>"
            str =  str + "            <tr style='height: 1%'> "
            str =  str + "                <td style='width: 30%'> "
			str =  str + "                    ID</td> "
            str =  str + "                <td style='width: 70%' nowrap>: " + idGridList.GetGridData( i, G1_member_id) 
            str =  str + "                </td>"
            str =  str + "            </tr>"
            str =  str + "            <tr style='height: 1%'>"
            str =  str + "                <td >"
            str =  str + "                    Name</td>"
            str =  str + "                <td >: " + idGridList.GetGridData( i, G1_member_name) 
            str =  str + "                </td>"
            str =  str + "            </tr>"
            str =  str + "            <tr style='height: 1%'>"
            str =  str + "                <td nowrap>"
            str =  str + "                    Register Date</td>"
            str =  str + "                <td >: " + idGridList.GetGridData( i, G1_red_date) 
            str =  str + "                </td>"
            str =  str + "            </tr>"
            str =  str + "            <tr style='height: 1%'>"
            str =  str + "                <td >"
            str =  str + "                    Mobile</td>"
            str =  str + "                <td >: " + idGridList.GetGridData( i, G1_mobiphone) 
            str =  str + "               </td>"
            str =  str + "             </tr>"
            str =  str + "             <tr style='height: 1%'>"
            str =  str + "                 <td >"
            str =  str + "                     Address</td>"
            str =  str + "                 <td >: " + idGridList.GetGridData( i, G1_address) 
            str =  str + "                 </td>"
            str =  str + "             </tr>"
            str =  str + "         </table>"
            str =  str + "     </td>"
            str =  str + " </tr> "
        
        str = str + " </table> "
        str =  str + "     </td>"
        str =  str + "     <td width='2%'> " 
        str =  str + "     </td>"  
        str =  str + "     <td width='49%'> "  
        if( (i+1)< trl.Rows)
        {     
            str = str +" <table style=' width: 100%;height: 100%' border='1'> "
           
           
                str =  str + " <tr style='height: 1%' > "
                str =  str + "     <td width='20%'> "
                str =  str + "        <img width=100 height=90  src='../../../system/binary/ViewFile.aspx?img_pk=" + idGridList.GetGridData( i+1, G1_tcm_photo_pk)+ "&table_name=CRM.TGM_MEMBERPHOTO' /> "
                str =  str + "     </td> "
                str =  str + "    <td <td width='70%'>"
                str =  str + "        <table style='height: 100%; width: 100%' border='0'>"
                str =  str + "            <tr style='height: 1%'> "
                str =  str + "                <td style='width: 30%'> "
                str =  str + "                    ID</td> "
                str =  str + "                <td style='width: 70%' nowrap >: " + idGridList.GetGridData( i+1, G1_member_id) 
                str =  str + "                </td>"
                str =  str + "            </tr>"
                str =  str + "            <tr style='height: 1%'>"
                str =  str + "                <td >"
                str =  str + "                    Name</td>"
                str =  str + "                <td >: " + idGridList.GetGridData( i+1, G1_member_name) 
                str =  str + "                </td>"
                str =  str + "            </tr>"
                str =  str + "            <tr style='height: 1%'>"
                str =  str + "                <td nowrap>"
                str =  str + "                    Register Date</td>"
                str =  str + "                <td >: " + idGridList.GetGridData( i+1, G1_red_date) 
                str =  str + "                </td>"
                str =  str + "            </tr>"
                str =  str + "            <tr style='height: 1%'>"
                str =  str + "                <td >"
                str =  str + "                    Mobile</td>"
                str =  str + "                <td >: " + idGridList.GetGridData( i+1, G1_mobiphone) 
                str =  str + "               </td>"
                str =  str + "             </tr>"
                str =  str + "             <tr style='height: 1%'>"
                str =  str + "                 <td >"
                str =  str + "                     Address</td>"
                str =  str + "                 <td >: " + idGridList.GetGridData( i+1, G1_address) 
                str =  str + "                 </td>"
                str =  str + "             </tr>"
                str =  str + "         </table>"
                str =  str + "     </td>"
                str =  str + " </tr> "
                str = str + " </table> "
            }
            str =  str + "     </td>"         
            str =  str + " </tr> "
        }     
        str =  str + " <tr style='height: 99%' > "
        str =  str + "     <td colspan=3> "
        str =  str + "     </td>"
        str =  str + " </tr> "
        str = str + " </table> ";
    } 
    tableView.innerHTML = str
    //tableView.innerText = str
 }
//------------------------------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
 <gw:data id="dsoMemberList" onreceive="OnDataReceive(this)" > 
        <xml> 
           <dso id="1" type="grid" function="crm.sp_sel_jams0020" > 
                <input bind="idGridList" > 
				    <input bind="lstMemberType" />
                    <input bind="idMemberId" />
                    <input bind="idMemberNm" />
                </input> 
                <output bind="idGridList" /> 
            </dso> 
        </xml> 
</gw:data> 	
  <!-------------------------------------------------------------------->
    <table style=' width: 100%;height: 100%'  cellpadding="0" cellspacing="0">
		<tr style='height: 1%'>
		    <td width=5%> Type </td>
			<td style="width:20%">
                   <gw:list id="lstMemberType" styles='width:100%' onchange="OnSearch()" />
            </td>
			<td style=' width: 7%; white-space:nowrap' align="right">Member Id</td>
			<td style=' width: 10%' align="right"><gw:textbox id="idMemberId" styles="width:97%" text="" csstype="filter" onenterkey="OnSearch()" /> </td>
			<td style=' width: 7%' align="right"> Name</td>
			<td style=' width: 23%' align="right"><gw:textbox id="idMemberNm" styles="width:97%" text="" csstype="filter" onenterkey="OnSearch()" /> </td>
			<td style=' width: 7%' align="right">Total:</td>
			<td style=' width:5%' align="right"><gw:label id="lblTotal" /> </td>
			<td style=' width: 5%' align="right"><gw:imgBtn id="idSearch"  alt="Search"  img="search"  onclick="OnSearch()" /></td>
		</tr>
		<tr style='height: 99%'>
			<td colspan="9" >
				<div  id="viewImg" style=" height:100%; overflow:scroll">
                </div>
			</td>
		</tr>	
	</table>           
<!--------------------------------------------->
        
<!------------------------------------------->
<gw:textbox id="imagePK" styles='width:100%;display:none' csstype="" />
<gw:textbox id="tcm_member_PK" styles='display:none' />
<gw:grid
	id="idGridList"
    header='_pk|_member_id|member_name|_birthday|_address|_country|_telephone|_mobiphone|email|_red_date|tcm_photo_pk'
    format='0|0|0|0|0|0|0|0|0|0|0'
    aligns='0|0|0|0|0|0|0|0|0|0|0'
    defaults='||||||||||'
    editcol='0|0|0|0|0|0|0|0|0|0|0'
    widths='0|0|0|0|0|0|0|0|0|0|0'
	styles="width:100%; heigth:456; display:none" />
</body>
</html>