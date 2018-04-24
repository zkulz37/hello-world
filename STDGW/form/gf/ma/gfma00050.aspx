<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ADVANCE REQUEST ENTRY</title>
</head>
<%  ESysLib.SetUser("acnt")%>

<script>
var flag;
var dflag;
var _book_rate = 0;
var book_format='';
var trs_format='';
var data ;
//--------------------------------------------------------------------- 
function BodyInit()
{
    System.Translate(document);  // Translate to language session
    BindingDataList();
   
}
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
    imgArrow.src = "../../../system/images/left.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/right.gif";
    }
}

//-------------------------------------------------------------------

 function BindingDataList()
 {      
     var arr;
    
     data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.sf_a_get_company('') FROM DUAL")%>";   
     cboCompany.SetDataText(data);
     data = ("<%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where  del_if=0")%>"); 
     cbodept.SetDataText(data+ "|0|Select ALL");
     cbodept.SetDataText('0');
     
     
     OnNew(0);
     SetGridFormat();
 }
 //---------------------------------------------------------------------------------------------------
 
 function SetGridFormat()
 {
    var ctr = grdAdvanceList.GetGridControl(); 
    ctr.ColFormat(5) = "#,###,###,###,###,###.##";
    ctr = grdSpendingList.GetGridControl(); 
    ctr.ColFormat(5) = "#,###,###,###,###,###.##";
 }

//--------------------------------------------------------------------------------------------------
function OnNew(index)
{
    switch(index)
    {   
        case 0:
            flag='new';
            data_gfma00050_3.StatusInsert();
             thr_employee_pk.text= "<%=session("EMPLOYEE_PK")%>";
             cbodept.value= "<%=session("DEPT_PK")%>";
           
             
            dat_gfma00050_5.Call();
        break;
        case 1:
            if(txtMasterpk.GetData()=='')
            {
                alert('Please save master first.');
                return false;
            }
            if(txtEmployeePK.GetData()!='')
            {
                dflag='new';
                var fpath   = System.RootURL + "/form/gf/ma/gfma00050_1.aspx?emp_pk=" + txtEmployeePK.GetData() +'&empid='+ txtEmployeeID.GetData();
                oValue      = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
                if (oValue != null)
                {  
                  for ( var i=0; i<oValue.length;i++)
                  {               
                    var aValue=oValue[i];
                    aValue = oValue[i];  
                    grdAdvanceList.AddRow();
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1, 0, aValue[0]); // _pk
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1, 2    ,aValue[2]); //Voucher
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1,3    ,aValue[3]); //date
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1,4    ,aValue[4]); //Reason
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1,5    ,aValue[5]); //Amount
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1,6    ,aValue[6]); //CCY
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1,7    ,aValue[7]); // 7.Ex. rate
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1,8    ,aValue[8]); //8_tac_empadvreq_pk
                    grdAdvanceList.SetGridText(grdAdvanceList.rows-1,9    ,txtMasterpk.GetData()); //txtMasterpk
                  }
                }
             }else{
                alert('You should select employee and save master first.');
             }   
        break;
        case 2:
             if(txtMasterpk.GetData()=='')
            {
                alert('Please save master first.');
                return false;
            }
            if(txtEmployeePK.GetData()!='')
            {
                var fpath   = System.RootURL + "/form/gf/ma/gfma00050_2.aspx?emp_pk=" + txtEmployeePK.GetData() +'&empid='+ txtEmployeeID.GetData();
                oValue      = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
                if (oValue != null)
                {  
                  for ( var i=0; i<oValue.length;i++)
                  {               
                    var aValue=oValue[i];
                    aValue = oValue[i];  
                    grdSpendingList.AddRow();
                    grdSpendingList.SetGridText(grdSpendingList.rows-1, 0, aValue[0]); // _pk
                    grdSpendingList.SetGridText(grdSpendingList.rows-1, 2    ,aValue[2]); //Voucher
                    grdSpendingList.SetGridText(grdSpendingList.rows-1,3    ,aValue[3]); //date
                    grdSpendingList.SetGridText(grdSpendingList.rows-1,4    ,aValue[4]); //Reason
                    grdSpendingList.SetGridText(grdSpendingList.rows-1,5    ,aValue[5]); //Amount
                    grdSpendingList.SetGridText(grdSpendingList.rows-1,6    ,aValue[6]); //CCY
                    grdSpendingList.SetGridText(grdSpendingList.rows-1,7    ,aValue[7]); // 7.Ex. rate
                    grdSpendingList.SetGridText(grdSpendingList.rows-1,8    ,aValue[8]); //8_tac_empadvreq_pk
                    grdSpendingList.SetGridText(grdSpendingList.rows-1,9    ,txtMasterpk.GetData()); //txtMasterpk
                  }
                }
             }else{
                alert('You should select employee and save master first.');
             }   
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
              data_gfma00050_3.Call();
            }  
          break;
          case 'adv':
            dflag='save';
            for(i=1;i<grdAdvanceList.rows-1;i++)
            {
                if(grdAdvanceList.GetGridData(i,1)=='-1' && grdAdvanceList.GetGridData(i,0)=='')
                {           
                     alert('new')       ;
                     grdAdvanceList.SetRowStatus(i, 0x20);
                }
            }
            dat_gfma00050_1.Call("");
          break;
          case 'spend':
            for(i=1;i<grdSpendingList.rows-1;i++)
            {
                if(grdSpendingList.GetGridData(i,1)=='-1' && grdSpendingList.GetGridData(i,0)=='')
                {                  
                     grdSpendingList.SetRowStatus(i, 0x20);
                }
            }
            dat_gfma00050_2.Call("");
          break;
    }
}
//------------------------------------------
function strToNumber(num)
{
	var tmp;
	tmp = num;
	var data = tmp.replace(",", "");
	tmp = data	
	data = tmp.replace(",", "");
	tmp = data	
	data = tmp.replace(",", "");
	tmp = data	
	data = tmp.replace(",", "");
	tmp = data	
	data = tmp.replace(",", "");
	tmp = data	
	data = tmp.replace(",", "");
	tmp = data	
	data = tmp.replace(",", "");
	return data;
}

//-------------------------------------------------------------------------------------
function totalamt()
{
    
    var amtA=0;
    var amtB=0;
    if(grdAdvanceList.rows >1){
        amtA=grdAdvanceList.GetGridData(grdAdvanceList.rows-1,5);
    }
    if(grdSpendingList.rows > 1){    
        amtB=grdSpendingList.GetGridData(grdSpendingList.rows-1,5);
    }    
    var amt1=0;
    var amt2=0;
    if(amtA!="")
    {
        amtA= strToNumber(amtA);
    }
    if(amtB !="")
    {    
        amtB= strToNumber(amtB);
    }
    if(Number(amtA) > Number(amtB))
    {
       
        amt1 = Number(amtA) - Number(amtB);
        amt2=0;
    }else{
         
        amt1=0;
        amt2 = Number(amtB) - Number(amtA);
    }
    txtamt1.SetDataText('' + amt1);
    txtamt2.SetDataText('' + amt2);
}
//-------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "dat_gfma00050_1": 
            grdAdvanceList.Subtotal(0,2,2,"5!5!5","",true,4,"TỔNG CỘNG A(Total A)");
            //grdAdvanceList.SetGridText(grdAdvanceList.rows-1,1,'')
            grdAdvanceList.GetGridControl().AutoSize(0,5,false,0);  
            totalamt();
            if(dflag=='view')
            {
                dat_gfma00050_2.Call('SELECT');
            }    
        break;
        case "dat_gfma00050_2":
            grdSpendingList.Subtotal(0,2,2,"5!5!5","",true,4,"TỔNG CỘNG B(Total B)");
           //grdSpendingList.SetGridText(grdSpendingList.rows-1,1,'')
            grdSpendingList.GetGridControl().AutoSize(0,5,false,0);  
            totalamt();
        break;
        case "data_gfma00050_3":
            if( flag=='delete' || flag=='update')
            {
                OnSearch(2);
            }
            else
            {
                OnSearch(0);
            }   
        break;
        case "dat_gfma00050_4":
            for(i=1;i<grdSearch.rows;i++)
            {
                grdSearch.SetGridText(i,1,i);
            }
        break;
    }
}
//------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------
function onValidate()
{
    if(txtEmployeePK.GetData()=='')
    {
        alert('You should select employee first.');
        txtEmployeeID.GetControl().focus();
        return false;
    }   
   
    return true;
}
//-----------------------------------------------------------------------------------
function OnSearch(index)
{
    switch (index)
    {
        case 0:
            if(txtEmployeePK.GetData()!='')
            {
                dat_gfma00050_1.Call("SELECT");
            }else{
                if(flag=='view'){
                    alert('You must select employee first');
                }    
            }    
        break;
        case 1:
            data_gfma00050_3.Call("SELECT");
        break;
         case 2:
            dat_gfma00050_4.Call("SELECT");
        break;
        case 3:
            txtMasterpk.text= grdSearch.GetGridData(grdSearch.row,0);
            dflag='view';
            flag='view';
            data_gfma00050_3.Call("SELECT");
        break;
    }
}
//------------------------------------------------------------------------
function OnPrintDTL()
{
    if(txtMasterpk.GetData()!='')
    {
        var url='';
        url =System.RootURL + '/reports/gf/ma/rpt_gfma00050_1.aspx?pk=' + txtMasterpk.GetData() + '&company_pk=' + cboCompany.GetData();
        url = url + '&totalA='+ grdAdvanceList.GetGridData(grdAdvanceList.rows-1,5) + '&totalB=' + grdSpendingList.GetGridData(grdSpendingList.rows-1,5);
        url = url + '&Bal_A=' + txtamt1.GetData()+ '&Bal_B=' + txtamt2.GetData();
        window.open(url); 
    }    
}
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/gf/ma/gfma00010_3.aspx';
            var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtEmployeeNm.text    = obj[2];
                txtEmployeePK.text  = obj[0];
                txtEmployeeID.text=obj[1];
            }
        break;  
     }
}        
//------------------------------------------------------------------------------------------------
function onDelete(index)
{
    switch(index)
    {
        case 0: // delete master
        
            if(grdAdvanceList.rows> 1 || grdSpendingList.rows > 1)
            {
                alert('Please delete detail first.');
                return false;
            }
            if(txtMasterpk.GetData()!='')
            {
                if(confirm('Do you want to delete this Voucher?'))
                {
                    flag='delete';
                    data_gfma00050_3.StatusDelete();
                    data_gfma00050_3.Call();
                }  
            }else{
                alert('No data to delete. Please select voucher first.');
            }    
        break;
        case 1: // delete advance
            if(confirm('Do you want to delete selected row ?'))
            {
                 dflag='delete';
                 grdAdvanceList.DeleteRow();
                 dat_gfma00050_1.Call();
            }
        break;
        case 2: // delete spending
            if(confirm('Do you want to delete selected row ?'))
            {
                 grdSpendingList.DeleteRow();
                 dat_gfma00050_2.Call();
            }
        break;
    }
}
//------------------------------------------------------------------------------------------------

</script>

<body>
    <!-------------1-------------------------------------------------------------->
   
 <gw:data id="dat_gfma00050_1"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"  parameter="0,8,9"  function="acnt.sp_sel_gfma00050_1" procedure="acnt.sp_upd_gfma00050_2"  > 
            <input bind="grdAdvanceList">                    
                <input bind="cboCompany" /> 
                <input bind="txtMasterpk" /> 
            </input> 
            <output bind="grdAdvanceList" /> 
        </dso> 
    </xml> 
</gw:data>
  <!----------------------------------------------------------------------------->
  <gw:data id="dat_gfma00050_2"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"   parameter="0,8,9" function="acnt.sp_sel_gfma00050_2" procedure="acnt.sp_upd_gfma00050_3"   > 
            <input bind="grdSpendingList"> 
                <input bind="cboCompany" />                    
                <input bind="txtMasterpk" /> 
            </input> 
            <output bind="grdSpendingList" /> 
        </dso> 
    </xml> 
</gw:data>  
 <gw:data id="data_gfma00050_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5" function="acnt.sp_sel_gfma00050_3" procedure="acnt.sp_upd_gfma00050_1">
                <input>
                    <inout bind="txtMasterpk" />
                    <inout bind="dbTransDate" />
                    <inout bind="cboCompany" />
                    <inout bind="cbodept" />
                    <inout bind="txtEmployeePK" />
                    <inout bind="txtVoucher" />
                    <inout bind="txtEmployeeID" />
                    <inout bind="txtEmployeeNm" />
                  </input>
            </dso>
        </xml>
    </gw:data>
  <!----------------------------------------------------------------------------->
  <gw:data id="dat_gfma00050_4"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid"    function="acnt.sp_sel_gfma00050_4"    > 
            <input bind="grdSearch"> 
                <input bind="dtFrom_ls" />                    
                <input bind="dtTo_ls" /> 
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>    
   <!--------------------------------------->
<gw:data id="dat_gfma00050_5" onreceive=""  > 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_gfma00050_1" > 
                <input>
                    <input bind="thr_employee_pk" /> 
               </input> 
                <output>
                    <output bind="txtEmployeeNm" />
                    <output bind="txtEmployeePK" />
                    <output bind="txtEmployeeID" />
               </output>
            </dso> 
        </xml> 
</gw:data>
  <!---------------------------------------------------------------------------->
  <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%" cellpadding=0 cellspacing=0 border="0">
                      
                      
                       <tr style="height: 2%" align="right">
                       
                        <td align="right" style="width: 25%">Voucher No</td>
                        <td style="width: 80%" colspan=4><gw:textbox id="txtAdvReqNo" styles="width:100%" /></td>
                       
                      </tr>
                      <tr style="height: 2%">
                     
                        <td align=right style="width: 25%">From </td>
                         <td align=left style="width: 25%"><gw:datebox id="dtFrom_ls" lang="1" /> </td>
                          <td align=center style="width: 1%">~</td>
                        <td align=left  style="width: 25%"><gw:datebox id="dtTo_ls" lang="1" /></td> 
                          <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch(2)" />
                        </td>
                    </tr>
                    
                     
                    <tr>
                        <td colspan="6">
                            <gw:grid 
                            id="grdSearch" 
                            header="_PK|No|Date|Voucher" 
                            format="0|0|0|1" 
                            aligns="0|3|0|2"
                            defaults="|||" 
                            editcol="0|0|0|0" 
                            widths="0|800|1200|2500" 
                            styles="width:100%; height:100%"
                            sorting="T" oncellclick="OnSearch(3)"  />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%" valign=top>
               <fieldset style="padding: 2">
	            <table border="0" width="100%" cellpadding=0 cellspacing=0 id="table1">
		            <tr>
            			
			            <td width="10%">Company</td>
                        <td width="35%" colspan=3><gw:list id="cboCompany" styles="width:100%;" /></td>
                        <td width="10%" align=right>Department</td>
                        <td width="40%" colspan=2><gw:list id="cbodept" onchange="" styles="width:100%;" /></td>
                       
                        <td  width=10%></td>
			            <td width=2%><gw:imgbtn id="btnsearch" img="search" alt="Search" onclick="OnSearch(0)" styles="width:100%;display:none" /></td>
			            <td width=2%><gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnNew(0)" /></td>
                        <td width=2%><gw:imgbtn id="btnSaveMST" img="save" alt="Save" onclick="OnSave('Master')" /></td>
                        <td width=2%><gw:imgbtn id="btnDeleteMST" img="delete" alt="Delete" onclick="onDelete(0)" /></td>
                        <td width=2%><gw:imgbtn id="btnexcel" img="excel" alt="Excel" onclick="OnPrintDTL()" /></td>
		            </tr>
		            <tr>
		                <td width="10%">Voucher No.</td>
                        <td width="15%"><gw:textbox id="txtVoucher" onenterkey="OnSearch(1)" onchange=""  styles="width:100%;" /></td>
                        <td width="10%" align=right>Trans. Date</td>
                        <td width="10%"><gw:datebox id="dbTransDate" lang="1" onenterkey="" onchange="" styles="width:100%;" /></td>
                         <td width="10%" align=right><a title="Click here to select Employee" onclick="OnPopUp('Charger')" href="#tips"
                                                 style="text-decoration: none; color=#0000ff"><b>Employee</b></a></td>
                        <td width="10%"><gw:textbox id="txtEmployeeID" onenterkey="OnSearch(0)" onchange="OnSearch(0)"  styles="width:100%;" /><gw:textbox id="txtEmployeePK" onenterkey="OnSearch(0)" onchange="OnSearch(0)"  styles="width:100%;display:none" /></td>
                       
                        <td width="30%" colspan=1><gw:textbox id="txtEmployeeNm" onenterkey="OnSearch(0)" onchange="OnSearch(0)" styles="width:100%;" /></td>
                        
                        
		            </tr>
		     
	            </table>
	            </fieldset>
	            <table border="0" width="100%" cellpadding=0 cellspacing=0 id="table3">
	                <tr>
	                    <!---0.pk|1.Select|2.Voucher No|3.Date |4.Reason|5.Amount|6.CCY|7.Ex. rate|8_tac_empadvreq_pk|9_masterpk-->
		                <td width="50%" align="justify" valign="top">
    		                <fieldset style="padding: 2">
			                <legend>A. Advance List </legend>
			                     <table border="0" cellpadding=0 cellspacing=0 width="100%">
	                                <tr>
		                                <td>&nbsp;</td>
		                                <td width="2%"><gw:imgbtn id="btnNewadv" img="new" alt="New" onclick="OnNew(1)" /></td>
		                                <td width="2%"><gw:imgbtn id="btnSaveadv" img="save" alt="Save" onclick="OnSave('adv')" /></td>
		                                <td width="2%"><gw:imgbtn id="btndeladv" img="delete" alt="Delete" onclick="onDelete(1)" /></td>
	                                </tr>
	                                <tr>
	                                    <td colspan=4>
	                                        <gw:grid id='grdAdvanceList' 
                                                header='_pk|_Select|Voucher No|Date |Reason|Amount|CCY|Ex. rate|_tac_empadvreq_pk|_masterpk'
                                                format='0|3|0|4|0|0|0|0|0|0'
                                                aligns='1|0|2|1|2|3|1|3|0|0'
                                                defaults='|||||||||'
                                                editcol='1|1|1|1|1|1|1|1|1|1'
                                                widths='0|800|2000|1200|2500|1200|500|1200|0|0'
                                                sorting='T'
                                                acceptNullDate="f"     
                                                oncellclick=""   
                                                oncelldblclick=""                      
                                                styles='width:100%; height:350'      
                                            />
                                        </td>
	                                </tr>
                                </table>
                            
                            </fieldset>
		                </td>
		                <td width="50%" align="justify" valign="top">
		                    <fieldset style="padding: 2">
		                    <legend>B. Spending List </legend>
		                        
		                        <table border="0" cellpadding=0 cellspacing=0 width="100%">
	                                <tr>
		                                <td>&nbsp;</td>
		                                <td width="2%"><gw:imgbtn id="btnNewpend" img="new" alt="New" onclick="OnNew(2)" /></td>
		                                <td width="2%"><gw:imgbtn id="btnSavespend" img="save" alt="Save" onclick="OnSave('spend')" /></td>
		                                <td width="2%"><gw:imgbtn id="btndelpend" img="delete" alt="Delete" onclick="onDelete(2)" /></td>
	                                </tr>
	                                <tr>
	                                    <td colspan=4>
	                                        <gw:grid id='grdSpendingList' 
                                                header='_pk|_Select|Voucher No|Date |Reason|Amount|CCY|Ex. rate|_tac_empadvreq_pk|_masterpk'
                                                format='0|3|0|4|0|0|0|0|0|0'
                                                aligns='1|0|2|1|2|3|1|3|0|0'
                                                defaults='|||||||||'
                                                editcol='1|1|1|1|1|1|1|1|1|1'
                                                widths='0|0|2000|1200|2500|1200|500|1200|0|0'
                                                sorting='T'
                                                acceptNullDate="f"     
                                                oncellclick=""   
                                                oncelldblclick=""                      
                                                styles='width:100%; height:350'
                                            />
                                        </td>
	                                </tr>
                                </table>
		                    
                                
                            </fieldset>
                        </td>
	                </tr>
                </table>
                <fieldset style="padding: 2">
                 <legend>C. Balance </legend>
	            <table border="0" width="100%" cellpadding=0 cellspacing=0 id="table2">
            		
		            <tr>
		                <td width="10%"></td>
                        <td width="10%"><gw:textbox id="txt1" text="A>B" readonly='true' styles="width:100%;color: #FF0000; font-weight: bold" /></td>
                        <td width="10%" align=right><gw:textbox id="txt2" readonly='true'  text="A-B"  styles="width:100%;color: #FF0000; font-weight: bold" /></td>
                        <td width="40%"><gw:textbox id="txtamt1" type="number" format="##,###,###,###.##R" readonly='true' styles="width:100%;color: #FF0000; font-weight: bold" /></td>
                        <td width="30%"></td>
                        
		            </tr>
		            <tr>
		                <td width="10%"></td>
                        <td width="10%"><gw:textbox id="txt3"  readonly='true' text="A<=B"  styles="width:100%;color: #FF0000; font-weight: bold" /></td>
                        <td width="10%" align=right><gw:textbox id="txt4" readonly='true' text="B-A"  styles="width:100%;color: #FF0000; font-weight: bold" /></td>
                        <td width="40%"><gw:textbox id="txtamt2" type="number" format="##,###,###,###.##R" readonly='true' styles="width:100%;color: #FF0000; font-weight: bold" /></td>
                        <td width="30%"></td>
		            </tr>
	            </table>
	            </fieldset>
            </td>
         </tr>
    </table>        
       <img status="expand" id="imgArrow" src="../../../system/images/right.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
 
	<gw:textbox id="txtMasterpk"  styles="width:100%;display:none" />
	<gw:textbox id="thr_employee_pk"  styles="width:100%;display:none" />

</body>
</html>
