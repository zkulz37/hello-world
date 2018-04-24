<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Basic Info for Uniform</title>
</head>
<%EsysLib.SetUser("HR") %>
<script>
/*var cur_row;
var emp_pk    = "<%=Session("EMPLOYEE_PK")%>";
var emp_id    = "<%=Session("EMP_ID")%>";
var log_id    = "<%=Session("LOGIN_ID")%>";
var emp_name  = "<%=Session("USER_NAME")%>";
var uniformpk = "<%=Request("p_app_pk")%>";

var col_emp     = 1;
var col_status  = 2;
var col_req_qty = 4;
var col_item    = 5;
var col_size    = 6;
var col_amount  = 7;
var col_rece    = 8;
var col_laundry = 9;
var col_emp_pk  = 10;*/

function BodyInit()
{       
  var data ="#F;FeMale|#M;Male"; 
        grdMember.SetComboFormat(4,data);
}
function OnCellClickMember()
{
    txtMasterPK.text = grdMember.GetGridData(grdMember.row,0);
    dso_grdMemberEvent.Call('SELECT');
}

function OnSave()
{
    //if(CheckDataIsValid() == true){
    dso_grdMemberEvent.Call();
    //}
}

function OnSearch()
{
   dso_grdMember.Call('SELECT');
}

function OnDelete()
{
    grdMemberEvent.DeleteRow();
    if(confirm("Do you want to delete this item?"))
    {
        dso_grdMemberEvent.Call();
    }
}
function OnNew()
{
   
   var setPK = "";
   if(txtMasterPK.GetData()!= "")
   {
        grdMemberEvent.AddRow();
        setPK = txtMasterPK.GetData();
        //alert(setPK);
            for (i = 1; i < grdMemberEvent.rows; i++)	
					if (grdMemberEvent.GetGridData(i, 1)  == "")
					{
						grdMemberEvent.SetGridText( i , 1, setPK);	

					}
	}
	else
	{
	    alert("Please select item of the member");
        return false;
	}
}

/*function CheckDataIsValid() 
        {
          for(var i=1;i<grdStudent.rows;i++)
          {
             if(grdStudent.GetGridData(i,1) == "")
             {
                alert("Please input student id.");
                return false;
             }
             if(grdStudent.GetGridData(i,2)=="")
             {
                alert("Please input student name!");
                return false;
             }
             if(grdStudent.GetGridData(i,6)=="")
             {
                alert("Please input gender!");
                return false;
             }
          }
          return true;
        }*/
</script>

<body>

<gw:data id="dso_grdMember" >
    <xml>
        <dso id="1" type="grid" function="crm.sp_sel_jams0050">
            <input bind="grdMember" >
				<input bind="txtName" />
            </input>
            <output bind="grdMember" />
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_grdMemberEvent" onreceive="">
    <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7" function="CRM.sp_sel_jams0050_1" procedure="CRM.sp_upd_jams0050">
            <input bind="grdMemberEvent" >
                <input bind="txtMasterPK" />
            </input>
            <output bind="grdMemberEvent" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
    <tr>
        <td width="35%" style="background: white">
            <table  width="100%" height="100%" border="0" >			    
			    <tr>
				    <td  width="20%">Name</td>
				    <td align = "left" width="50%">
					    <gw:textbox id="txtName" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearch()"  />
				    </td>
				    <td width="3%">
                        <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                   </td>
			    </tr>
				<tr width="100%" height="100%" >
					<td colspan="3" >
						<gw:grid   
						id="grdMember"  
						header="_PK|Member ID|Member Name|Card Number|Gender"
						format ="0|0|0|0|0"
						aligns ="0|0|0|0|0"
						default="0|0|0|0|0"
						editcol="0|0|0|0|0"
						widths ="0|1500|2500|1500|1200"
						styles="width:100%; height:100%"   
						sorting="T"   
						acceptNullDate="T"
						autosize='T' 
						oncellclick="OnCellClickMember()"  />
					</td>
				</tr>
			</table>
        </td>
        <!------------------------------------------------------------------->
        <td width="65%" style="background: white">
            <table width="100%" width="100%" height="100%">
                <tr valign="top" style="background: #BDE9FF" height="5%" >        
                    <td style="background: white">
                    <fieldset>
                        <table width="100%" border="0">
                            <tr width="100%">
                            <td width="81%"></td>
                                <td width="3%">
                                    <gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="OnNew()" />
                                 </td>
                                <td width="3%" ><gw:imgBtn img="delete" alt="Delete"   onclick ="OnDelete()"/></td>
                                <td width="3%" ><gw:imgBtn img="save"   alt="Save"     onclick ="OnSave()"/></td>
                            </tr>
                        </table>
                        </fieldset>
                    </td>           
                </tr>
                <tr valign="top" height="90%">
                    <td colspan="4" width="100%" >
                        <gw:grid   
                        id="grdMemberEvent"  
                        header="_MemberEventPK|_MEMBER_PK|Event Name|Event LName|Event FName|Event Date|Description|Active"
                        format="0|0|0|0|0|4|0|3"
                        aligns="0|0|0|0|0|0|0|0"
                        defaults="|||||||"
                        editcol="1|1|1|1|1|1|1|1"
                        widths="0|0|1200|1500|1000|2500|2500|1000"
                        styles="width:100%; height:100%"  
                        autosize='T' 
                        sorting="T"
                        />
                    </td>
                </tr>
            </table>
        </td>
    </tr>    
</table>
<gw:textbox id="txtMasterPK" styles="width:100%;display:none" /> 
</body>