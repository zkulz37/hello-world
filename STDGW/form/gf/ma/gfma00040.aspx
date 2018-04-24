<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ADVANCE REQUEST ENTRY</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>

var flag;
var _book_rate = 0;
var book_format='';
var trs_format='';
var data ;
//--------------------------------------------------------------------- 

function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}

//-------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
   
    BindingDataList();
}
//---------------------------------------------------------------------  

 function BindingDataList()
 {      
   
     var arr;
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.sf_a_get_company('') FROM DUAL")%>";   
     cboCompany.SetDataText(data);
     data = ("<%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0")%>"); 
     cbodept.SetDataText(data+ "|0|Select ALL");
     cbodept.SetDataText('0');
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('ACBG0010') FROM DUAL")%>";   
     cboStatus.SetDataText(data+ "|ALL|Select ALL");
     cboStatus.SetDataText('ALL');
     
     <%=ESysLib.SetGridColumnComboFormat("grdMaster", 7,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>;
     <%=ESysLib.SetGridColumnComboFormat("grdMaster", 13," SELECT pk, partner_name  FROM comm.tco_company        WHERE del_if = 0")%>;
     <%=ESysLib.SetGridColumnComboFormat("grdMaster", 9,"SELECT a.code, a.code_nm  FROM tac_commcode_detail a, tac_commcode_master b WHERE a.del_if = 0 AND b.del_if = 0 AND b.ID = 'ACBG0010' AND a.tac_commcode_master_pk = b.pk AND a.use_yn = 'Y'")%>;
     SetGridFormat();
     
 }
 //---------------------------------------------------------------------------------------------------
 
 function SetGridFormat()
 {
    var ctr = grdMaster.GetGridControl(); 
    ctr.ColFormat(6)        = "#,###,###,###,###,###.##";
   
 }

//--------------------------------------------------------------------------------------------------
function OnNew(index)
{
    switch(index)
    {
        case 0: // master
            grdMaster.AddRow();
            grdMaster.SetGridText(grdMaster.rows-1,13,cboCompany.GetData());
            grdMaster.SetGridText(grdMaster.rows-1,9,"1");
        break;
        case 1: // Detail
            if(grdMaster.row < 1)
            {
                alert('Please select master first');
                return false;
            }
            grdDetail.AddRow();
            grdDetail.SetGridText(grdDetail.rows-1,1,grdMaster.GetGridData(grdMaster.row,0));
           
        break;
    }
}  
//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if(onValidate())
            {
                flag='update';
                for (i = 1; i < grdMaster.rows; i++)
                {
                    if(grdMaster.GetGridData(i,0) == ''){
                        grdMaster.SetRowStatus(i, 0x20);
                     }
                }  
                dat_gfma00040_1.Call("");
            }  
          break;
        case 'Detail':        
            /*for (i = 1; i < grdDetail.rows; i++)
            {
                if(grdDetail.GetGridData(i,0) == ''){
                    grdDetail.SetRowStatus(i, 0x20);
                 }
            }   */     
            dat_gfma00040_2.Call("");
        break;
    }
}
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "dat_gfma00040_2": 
            for(j=1; j < grdDetail.rows; j++)
            {
                grdDetail.SetGridText(j,2,j);
            }
          
        break;
      
    }
}
//-------------------------------------------------------------------------------------
function onValidate()
{
    
   
    return true;
}
//-------------------------------------------------------------------------------------
function DBPopupClick()
{
    if (event.col == 1)
	{
	     var path = System.RootURL + '/form/gf/ma/gfma00040_1.aspx';
         var obj = System.OpenModal( path ,600 , 450 ,  'resizable:yes;status:yes');
         if ( obj != null )
         {
            grdMaster.SetGridText(grdMaster.row,14,obj[0]);
            grdMaster.SetGridText(grdMaster.row,1,obj[1]);
         }
    }
    if (event.col == 2 || event.col==3 )
	{
	    var path = System.RootURL + '/form/gf/ma/gfma00010_3.aspx';
        var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
        if ( obj != null )
        {
            grdMaster.SetGridText(grdMaster.row,2,obj[1]);
            grdMaster.SetGridText(grdMaster.row,3,obj[2]);
            grdMaster.SetGridText(grdMaster.row,15,obj[0]);
        }
    }
}
//-----------------------------------------------------------------------------------
function OnSearch(index)
{
    switch (index)
    {
        case 0:
            dat_gfma00040_1.Call("SELECT");
        break;
        case 1:
            flag='view';
            var row  = grdMaster.row;
	        txtMasterpk.text  = grdMaster.GetGridData(row,0);
	        dat_gfma00040_2.StatusSelect();  
	        dat_gfma00040_2.Call("SELECT");
        break;
    
    }
}

//------------------------------------------------------------------------------------------------

 function OnDelete(index)
 {        
    switch (index)
    {
        case 0:// delete master
            if(confirm('Do you want to delete selected invoice?'))
            {
                flag='delete';
                grdMaster.DeleteRow();
                dat_gfma00040_1.Call();
            }   
        break;
            
        case 1:// delete document
            if(confirm('Do you want to delete selected row(s) ?'))
            {
                 grdDetail.DeleteRow();
                 dat_gfma00040_2.Call();
            }
        break;

    }     
}


//------------------------------------------------------------------------------------------------

</script>

<body>
    <!-------------1-------------------------------------------------------------->
   
 <gw:data id="dat_gfma00040_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"   parameter="0,4,5,6,7,8,9, 11,12,13,14,15" function="acnt.sp_sel_gfma00040_2" procedure="acnt.sp_upd_gfma00040_1"   > 
            <input bind="grdMaster">                    
                <input bind="cboCompany" /> 
                <input bind="txtInv" />
                <input bind="cbodept" /> 
                <input bind="txtamt" />
                <input bind="cboStatus" />
                <input bind="dtFrom_s" /> 
                <input bind="dtto_s" />
            </input> 
            <output bind="grdMaster" /> 
        </dso> 
    </xml> 
</gw:data>
  <!----------------------------------------------------------------------------->
  <gw:data id="dat_gfma00040_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"   parameter="0,1,3,4,5" function="acnt.sp_sel_gfma00040_3" procedure="acnt.sp_upd_gfma00040_2"   > 
            <input bind="grdDetail">                    
                <input bind="txtMasterpk" /> 
            
            </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>  
  <!---------------------------------------------------------------------------->
   <fieldset style="padding: 2">
	<table border="0" width="100%" cellpadding=0 cellspacing=0 id="table1">
		<tr>
			
			<td align="right" width="10%">Company</td>
            <td width="20%"><gw:list id="cboCompany" styles="width:100%;" /></td>
            <td align="right" width="10%">Department</td>
            <td width="20%"><gw:list id="cbodept" onchange="OnSearch(0)" styles="width:100%;" /></td>
            <td align="right" width="10%">Status</td>
            <td width="20%"  colspan=3><gw:list id="cboStatus" onchange="OnSearch(0)" styles="width:100%;" /></td>
            <td  width=5%></td>
			<td ><gw:imgbtn id="btnsearch" img="search" alt="New" onclick="OnSearch(0)" /></td>
			<td ><gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnNew(0)" /></td>
            <td ><gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave('Master')" /></td>
            <td ><gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="OnDelete(0)" /></td>
          
		</tr>
		<tr>
			
			
            <td align="right" width="10%">Invoice No.</td>
            <td width="15%"><gw:textbox id="txtInv" onenterkey="OnSearch(0)" onchange="OnSearch(0)"  styles="width:100%;" /></td>
            <td align="right" width="10%">Amount</td>
            <td width="10%"><gw:textbox id="txtamt" onenterkey="OnSearch(0)" onchange="OnSearch(0)" styles="width:100%;" /></td>
            <td align="right" width="10%">From</td>
            <td align=left ><gw:datebox id="dtFrom_s" onchange="OnSearch(0)" lang="1" /> </td>
            <td  width=1%>~</td>
            <td align=left ><gw:datebox id="dtto_s" onchange="OnSearch(0)" lang="1" /> </td>
            <td  width=5% colspan=3></td>
			
		</tr>
	</table>
	</fieldset>
    <table border="1" width="100%" cellpadding=0 cellspacing=0 id="table2">
		
		<tr>
<!--0_pk|1.Department|2.Emp ID|3.Employee|4.INV. Date|5.Invoice No|6.Amount|7.ccy|8.Ex. rate|9.Status|10.Approved dt|11.Description|11.Local Description|13.Company|14_dept_pk|15._eMP_PK-->
            <td colspan="15" width="100%">
                <gw:grid id='grdMaster' 
                    header='_pk|Department|Emp. ID |Emp. Name|INV. Date|Invoice No|Amount|ccy|Ex. rate|Status|Approved dt|Description|Local Description|Company|_dept_pk|_eMP_PK'
                    format='0|0|0|0|4|0|0|0|0|0|4|0|0|0|0|0'
                    aligns='0|2|2|2|1|2|3|1|3|1|1|2|2|2|0|0'
                    defaults='|||||||||||||||'
                    editcol='1|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1'
                    widths='0|1800|1000|2500|1200|1500|1300|500|1000|1500|1200|2500|2500|2500|0|0'
                    sorting='T'
                    acceptNullDate="f"     
                    oncellclick="OnSearch(1)"   
                    oncelldblclick="DBPopupClick()"                      
                    styles='width:100%; height:300'
                   
                  />
            </td>   
		</tr>
		<tr>
			
			
            <td  width="95%" colspan="12"></td>
			
			 <td width="1%"><gw:imgbtn id="btnNewD" img="new" alt="New" onclick="OnNew(1)" /></td>
             <td width="1%"><gw:imgbtn id="btnSaveD" img="save" alt="Save" onclick="OnSave('Detail')" /></td>
             <td width="1%"><gw:imgbtn id="btnDeleteD" img="delete" alt="Delete" onclick="OnDelete(1)" /></td>
             
		</tr>
		<tr>
			<!--0_pk|1_pk_master|2.No|3.Amount|4.Description|5.Local Description-->
            <td colspan="15" width="100%">
                <gw:grid id='grdDetail' 
                    header='_pk|_pk_master|No|Amount|Description|Local Description'
                    format='0|0|0|0|0|0'
                    aligns='0|0|1|3|2|2'
                    defaults='||||'
                    editcol='0|0|1|1|1|1'
                    widths='0|0|1500|3000|5000|5000'
                    sorting='T'
                    acceptNullDate="T"                              
                    styles='width:100%; height:160'
                   
                  />
            </td>   
		</tr>
	</table>
	<gw:textbox id="txtMasterpk"  styles="width:100%;display:" />
</body>
</html>
