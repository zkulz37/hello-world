<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>BL View</title>
  </head>
  
 <% ESysLib.SetUser("prod")%>
 
 <script>
 //---------------------------------------------------------
 function BodyInit()
 { 
    BindingDataList();
    
 }
 //---------------------------------------------------------
 
 function BindingDataList()
 {   
        var data1 ="<%= ESysLib.SetListDataSQL(" select pk,partner_id from tco_company where del_if = 0") %>";
        <%=  ESysLib.SetGridColumnComboFormat("grdBL", 8," select a.CODE, a.CODE_NM  from comm.TCO_ABCODE a, comm.TCO_ABCODEGRP b where a.TCO_ABCODEGRP_PK = b.PK and b.ID = 'PRCP0070' and a.DEL_IF = 0 and b.DEL_IF = 0 order by a.CODE_NM")%>;
        <%=  ESysLib.SetGridColumnComboFormat("grdBL", 1," select pk,partner_id from tco_company where del_if = 0")%>;
        cboCompany.SetDataText(data1);
 }

function  OnNewClick()
{
    grdBL.AddRow();
    grdBL.SetGridText(grdBL.rows-1,1,cboCompany.GetData());
    
}
 
function OnSearchClick()
{
    grdBL.ClearData();
    idBLInfo.Call('SELECT');
}

function  OnDeleteClick()
{
        if (confirm("Do you want to delete ?"))
        {
            grdBL.DeleteRow();
            idBLInfo.Call('');
        }
}



function OnSaveClick()
{
    if (checkValidData())
   {
            idBLInfo.Call('');
   } 
}

function OnSelectClick()
{
    var r_data = new Array()
   if(grdBL.row > 0 &&  grdBL.GetGridData(grdBL.row,0) > 0)
   {
      r_data[0] = grdBL.GetGridData(grdBL.row,0);
      r_data[1] = grdBL.GetGridData(grdBL.row,1);
      r_data[2] = grdBL.GetGridData(grdBL.row,2);
      r_data[3] = grdBL.GetGridData(grdBL.row,3);
      r_data[4] = grdBL.GetGridData(grdBL.row,4);
       r_data[5] = grdBL.GetGridData(grdBL.row,5);
       r_data[6] = grdBL.GetGridData(grdBL.row,6);
       r_data[7] = grdBL.GetGridData(grdBL.row,7);
       r_data[8] = grdBL.GetGridData(grdBL.row,8);
       r_data[9] = grdBL.GetGridData(grdBL.row,9);
       r_data[10] = grdBL.GetGridData(grdBL.row,10);

      window.returnValue = r_data;
      window.close(); 
   } 

}

function OnCloseClick()
{
    window.close(); 
}

function RemoveBlankRows()
{
    var i = 1;
	while(i<grdBL.rows)
	{
		var pk = Number(grdBL.GetGridData(i,0));
		var ci_no = Trim(grdBL.GetGridData(i,1));
		var bl_id = Trim(grdBL.GetGridData(i,3));
		if( ((pk == 0)&&(ci_no == "")) && (pl_id == "") )
		{
			grdBL.RemoveRowAt(i);
		}
		else
		{
		   i = i+1;
		}
	}
}


function BLCellClick()
{
    if (event.col ==3)
   {
        var fpath = System.RootURL + "/form/fp/ab/fpab00120.aspx";
        oValue = System.OpenModal( fpath , 600 , 350, 'resizable:yes;status:yes');
        if ( oValue != null)
        {
                grdBL.SetGridText(grdBL.row,2,oValue[0]);
               grdBL.SetGridText(grdBL.row,3,oValue[2]); 
        }
   } 
}

function checkValidData()
{
    var i = 1;
	while(i<grdBL.rows)
	{
	    if (grdBL.GetGridData(i,1)=="")
	    {
	        alert("Please chose company !");
	        return 0;
	    }
	    if (grdBL.GetGridData(i,3)=="")
	    {
	        alert("Please chose Vendor !");
	        return 0;
	    }
	    if (grdBL.GetGridData(i,4)=="")
	    {
	        alert("Please enter CI No !");
	        return 0;
	    }
	    if (grdBL.GetGridData(i,5)=="")
	    {
	        alert("Please enter B/L No !");
	        return 0;
	    }
	    
	     if (grdBL.GetGridData(i,6)=="")
	    {
	        alert("Please set B/L Date !");
	        return 0;
	    }
	     if (grdBL.GetGridData(i,7)=="")
	    {
	        alert("Please set B/L ETA !");
	        return 0;
	    }
	     if (grdBL.GetGridData(i,8)=="")
	    {
	        alert("Please chose Status !");
	        return 0;
	    }
	    i++;
	}
	return 1;
}

function onGetError(object)
{
    if (object.id =="idBLInfo")
   {
        var l_msg_arr = idBLInfo.errmsg;
        var l_msg = l_msg_arr.split('#');
        alert(l_msg[1]);
         idBLInfo.Call('SELECT');
   } 
}
 </script>

<body style=" margin-right:0;">

 <gw:data id="idBLInfo"  onreceive=""  > 
        <xml>                                   
             <dso id="1" type="grid" parameter="0,1,2,4,5,6,7,8,9,10" function="prod.sp_sel_blseastock"  procedure="prod.sp_upd_blseastock"> 
              <input  bind="grdBL">
                    <input bind="cboCompany" /> 
                    <input bind="txtCINo" />
                    <input bind="dtbFrom" /> 
                    <input bind="dtbTo" /> 
                </input> 
                <output bind="grdBL" /> 
            </dso> 
        </xml> 
</gw:data> 
  <table border="1" cellpadding="0" cellspacing="0" width="100%">
        <tr valign="top">
                <td>
                       <table border="0" cellpadding="0" cellspacing="0" style=" margin-top:2;margin-right:0;">
                            <tr>
                                    <td width="10%" ><b>&nbsp;&nbsp;Company&nbsp;</b></td>
                                    <td width="20%"><gw:list id="cboCompany"   styles="width:98%;" ></gw:list></td>
                                    <td  width="13%" >&nbsp;&nbsp;&nbsp;&nbsp;<b>C/I No </b></td>
                                    <td  width="20%"><gw:textbox id="txtCINo" styles='width:100%'  onenterkey="OnSearchClick()" /></td>
                                    <td width="12%">&nbsp;&nbsp;<b>B/L Date</b></td>
                                    <td width="15%">
                                            <table border="0" cellpadding="1" cellspacing="2">
                                                <tr>
                                                    <td width="45%"><gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01" onchange=""  /></td>
                                                    <td width="10%"><b>&nbsp;~&nbsp;</b></td>
                                                    <td width="45%"><gw:datebox id="dtbTo" lang="<%=Application("Lang")%>" mode="01" onchange="" /></td>
                                                </tr>
                                        </table>
                                    </td>
                                    <td width="10%" align="right">
                                        <table border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="3%"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" text="Search"  onclick="OnSearchClick()" /></td>
                                                <td width="3%"><gw:imgBtn id="ibtnNew" img="new" alt="New" text="New"  onclick="OnNewClick()" /></td>
                                                <td width="3%"><gw:imgBtn id="ibtnDelete" img="delete" alt="Delete" text="Delete"  onclick="OnDeleteClick()" /></td>
                                                <td width="3%"><gw:imgBtn id="ibtnSave" img="save" alt="Save" text="Save"  onclick="OnSaveClick()" /></td> 
                                                 <td width="3%"><gw:imgBtn id="ibtnSelect" img="select" alt="Select" text="Select"  onclick="OnSelectClick()" /></td> 
                                                <td width=3%><gw:imgBtn id="ibtnClose" img="cancel" alt="Close window" onclick="OnCloseClick()"/> </td> 
                                                <!-- 
                                                 <td width="3%"><gw:imgBtn id="ibtnClose" img="save" alt="Close" text="Close"  onclick="OnCloseClick()" /></td>  
                                                --> 
                                            </tr>
                                        </table>
                                </td>
                            </tr>
                        </table> 
                </td>
        </tr>
        <tr >
                <td valign="top">
               <gw:grid   
                    id="grdBL"  
                    header="_a.pk|Company|_a.tco_buspartner_pk|Vendor|CI No|B/L No|B/L Date|B/L ETA|B/L Status|Close|_Close Date"   
                    format="0|2|0|0|0|0|4|4|2|3|4"  
                    aligns="0|0|0|0|0|0|0|0|0|0|0"  
                    defaults="||||||||||"  
                    editcol="1|1|1|1|1|1|1|1|1|1|1"  
                    widths="0|2000|0|2500|1500|1500|1500|1500|1500|500|0"  
                    styles="width:100%; height:400"   
                    sorting="F"   
                    oncelldblclick="BLCellClick()"
                    param="0,1,2,3,4,5,6,7,8,9,10"  /> 
                </td>
        </tr>
  </table>
</body>
</html>
