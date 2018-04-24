<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Register Outside Order Work</title>
</head>
<%  ESysLib.SetUser("ec111")%>

<script>
var Insert      = 'F';
var Modify      = 'F';
var Delete    = 'F';

function BodyInit()
{
      System.Translate(document);
	  BindingDataList();
      MergeHeader();  
      dso_update.StatusInsert();
	  Insert = 'T';
}
//====================================================================================================================
function BindingDataList()
{
			var ls_VersionNo = "<%=ESysLib.SetListDataSQL("select pk, UNDERTAKECHANGESEQ from ec111.tecps_undertakectrtbasc where del_if = 0 and CONFIRMYN = 'Y' order by UNDERTAKECHANGESEQ ")%>||";
			//lstVersion_No.SetDataText(ls_VersionNo);
//			lstVersion_No.value = '';
			ls_Revision_Type = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('TPS0025') FROM DUAL")%>";
			lstRevision_Type.SetDataText(ls_Revision_Type);	
			ls_Working_Desc = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_COMMONCODE('TPS0026') FROM DUAL")%>";
			lstBudget_Description.SetDataText(ls_Working_Desc);	
			var ls_Contract_Ccy = "<%=ESysLib.SetListDataSQL("SELECT CODE, CODE  FROM comm.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK =b.pk and b.id='ACAB0110' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 order by a.DEF_YN desc , ord")%>";
            lstContract_Ccy.SetDataText(ls_Contract_Ccy); 
			var ls_company = "<%=ESysLib.SetListDataSQL("SELECT pk, partner_name FROM comm.tco_company where del_if=0")%>";
			lstCompany.SetDataText(ls_company);
			lstCompany.value = "<%=session("company_pk") %>";
			OnChangeCurrent()
}
//====================================================================================================================
function MergeHeader()
{
        var fg=Grid_Contract.GetGridControl(); 	
        if(fg.Rows < 2)
		{
		   Grid_Contract.AddRow();     
		}    
        fg.FixedRows = 2
        fg.MergeCells =5	
        
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 2, 0, 4)  = "Contract"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 2, 1, 2) = "Key Curr."
	    fg.Cell(0, 1, 3, 1, 3) = "Corp. Curr. Convr. Exchg Rate" 
	    fg.Cell(0, 1, 4, 1, 4) = "Corp. Curr. Convr. Amt" 
	    
		fg.Cell(0, 0, 5, 0, 7)  = "Working"   //fg.Cell(0,row, from_col, row, to_col)	
	    fg.Cell(0, 1, 5, 1, 5) = "Key Curr."
	    fg.Cell(0, 1, 6, 1, 6) = "Corp. Curr. Convr. Exchg Rate" 
	    fg.Cell(0, 1, 7, 1, 7) = "Corp. Curr. Convr. Amt" 
		
	
	    
	    fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Description"	
		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Curr."	
}
//====================================================================================================================
function OnChangeCurrent()
{
    dso_get_rate.Call();
} 

//====================================================================================================================
function OnPopUp(obj)
{
        switch(obj)
        {
			case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProject_Pk.text = aValue[0];
									txtProject_Pk1.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2];  
									dso_version.Call();
                            } 
                break;
				case 'Revision':
					var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=TPS0025';
					var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
					 if (object != null )
					 {
						 lstRevision_Type.SetDataText(object[1]);
					 }
				break;
				case 'Budget_Description':
					var path = System.RootURL + '/form/gf/os/gfos00070_popup_1.aspx?code=TPS0026';
					var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
					 if (object != null )
					 {
						 lstBudget_Description.SetDataText(object[1]);
					 }
				break;
				case 'Prepared_By':
					var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
					var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
		 
					if ( obj != null )
					{
						txtPrepared_By_Nm.text = obj[2];
						txtPrepared_By_Pk.text   = obj[0];
						txtPrepared_By_Cd.text   = obj[1];
					}
				break;         

		}
}
//====================================================================================================================
function OnNew()
{
		if(txtProject_Pk1.text != '')
		{
					dso_update.StatusInsert();
					 Insert = 'T';
		}
		else
		{
				alert('Please select Project !!');	
				return false;
		}
}
//====================================================================================================================
function OnSave()
{
		if(txtRevision_No.text == '')
		{
				alert('Please input Change Serial No !!');
				txtRevision_No.GetControl().focus();	
		}
		else
		{
			txtProject_Pk.SetDataText(txtProject_Pk1.text);
			txtBudget_No.SetDataText(lstBudget_Description.value+ '.' + txtRevision_No.text+ '.' + '0');
			if(Grid_Detail.rows  == 1)
					 {
							txtSerial_No.SetDataText(0);
					 }
					 else
					 {
						 	 var Serial_No	= 0;
							 var i=0;
							if(Grid_Detail.rows>1)
							{
									Serial_No = 1 + Number(Grid_Detail.GetGridData(Grid_Detail.rows -1, 0));	
							} 
							else
							{
									return ;	
							}
							txtSerial_No.SetDataText(Serial_No);
					 }
			dso_update.Call();
		}
}
//====================================================================================================================
function OnSearch()
{
		if(txtProject_Pk1.text != '')
		{
				dso_search.Call("SELECT");
		}
		else
		{
				alert('Please select a Project !!');	
		}
}
//====================================================================================================================
function OnDelete()
{
	if(confirm('Are you sure you want to delete !!'))
		dso_update.StatusDelete();
		dso_update.Call();
		Delete='T';
}
//====================================================================================================================
function OnClick()
{
	txtPk.SetDataText(Grid_Detail.GetGridData(Grid_Detail.row, 9));
//	flag = 'search';   
	dso_update.Call("SELECT");
}
//====================================================================================================================
function OnDataReceive(obj)
{
		switch (obj.id)
		{
			case "dso_update":
			  if((Insert == 'T') || (Modify == 'T') || (Delete=='T'))
              {
                 	 Insert = 'F';
                     Modify = 'F';
                     Delete = 'F';
                  	 dso_search.Call("SELECT");
              }
			  else
			  {
			  		dso_detail.Call("SELECT");
			  }
			break;
			case  "dso_version":
					dso_search.Call("SELECT");
			break;
			case "dso_detail":
					MergeHeader();
			break;
		}
}
</script>

<body>
 <gw:data id="dso_update" onreceive="OnDataReceive(this)">
  <xml>
    <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="ec111.sp_sel_kpbm00020" procedure="ec111.sp_upd_kpbm00020" >
      <input>
          <inout bind="txtPk"/>
          
          <inout bind="txtBudget_No"/>
          <inout bind="lstVersion_No"/>
          <inout bind="lstRevision_Type"/>
          <inout bind="dtEx_Rate"/>
          
          <inout bind="dtWorking_Period_Fr"/>
          <inout bind="dtWorking_Period_To"/>
          <inout bind="txtPrepared_By_Pk"/>
          <inout bind="txtPrepared_By_Cd"/>
          <inout bind="txtPrepared_By_Nm"/>
          
          <inout bind="txtRemark"/>
          <inout bind="lstBudget_Description"/>
          <inout bind="lstContract_Ccy"/>
          <inout bind="txtRevision_No"/>
          <inout bind="txtEx_Rate"/>
          
          <inout bind="dtContract_Period_Fr"/>
          <inout bind="dtContract_Period_To"/>
          <inout bind="dtWorkingPeriodTarget_Fr"/>
          <inout bind="dtWorkingPeriodTarget_To"/>
          <inout bind="txtRReasonofRevision"/>
          
          <inout bind="txtProject_Pk"/>
          <inout bind="txtSerial_No"/>
      </input>
    </dso>
  </xml>
</gw:data>
<!------------------------------------------------------------------->
<gw:data id="dso_search" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid"   function="ec111.sp_sel_kpbm00020_1" >
                <input bind="Grid_Detail">
                    <input bind="txtProject_Pk1"/>
                </input>
                <output bind="Grid_Detail"/>
            </dso>
        </xml>
    </gw:data>
<!------------------------------------------------------------------->
 <gw:data id="dso_version" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="ec111.SP_PRO_SEL_kpbp00050" > 
            <input> 
                <input bind="txtProject_Pk" />
            </input>
	       <output>
	            <output bind="lstVersion_No" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>    

<gw:data id="dso_get_rate" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_GET_RATE"> 
                <input> 
                     <input bind="dtEx_Rate"/>
                     <input bind="lstCompany"/>
                     <input bind="lstContract_Ccy" />
                     <input bind="txt_row"/>
                </input>
                <output>
                     <output bind="txtEx_Rate"/>
                     <output bind="txt_row"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>

<gw:data id="dso_detail" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid"   function="ec111.sp_sel_kpbm00020_2" >
                <input bind="Grid_Contract">
                    <input bind="txtPk"/>
                </input>
                <output bind="Grid_Contract"/>
            </dso>
        </xml>
    </gw:data>
    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td width="100%">
                <fieldset style="padding: 0">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="15%">
                            </td>
                            <td align="right" width="10%">
                                <a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">
                                    Project&nbsp;</a></td>
                            <td width="50%">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="40%">
                                            <gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
                                        </td>
                                        <td width="60%">
                                            <gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
                                        </td>
                                        <td width="">
                                            
                                        </td>
                                        <td>
                                            <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';txtProject_Pk1.text='';" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnUpdte" img="search" alt="Search" onclick="OnSearch()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnpdte" img="new" alt="New" onclick="OnNew()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtnUpdate" img="save" alt="Save" onclick="OnSave()" />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="ibtUpdate" img="delete" alt="Delete" onclick="OnDelete()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="15%">
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 38%">
            <td colspan="4">
                <gw:grid id="Grid_Detail" 
                	header="S/No.|Approval Request No.|Change Times (Serial No.)|Corporation Ccy Conversion|Working Corporation Ccy Conversion Amt|Approval Status|Approved Date|Draw-up Date|Drafter|_pk|_TECPS_PERFORMCOSTRMRK_PK"
                    format="0|0|0|0|1|0|0|0|0|0|0" 
                    aligns="1|0|0|0|3|0|0|0|0|0|0" 
                    defaults="||||||||||"
                    editcol="1|1|1|1|1|1|1|1|1|1|1" 
                    widths="800|2000|2500|2500|3700|1500|1500|1500|1500|0|0"
                    styles="width:100%; height:100%" 
                    sorting="T" 
                    oncellclick="OnClick()"/>
            </td>
        </tr>
        <tr style="height: 10%">
            <td>
                <fieldset style="padding: 0">
                    <table cellpadding="1" cellspacing="1" width="100%">
                        <tr>
                            <td align="right" width="20%">
                                Budget Statement No</td>
                            <td width="30%">
                                <gw:textbox id="txtBudget_No" readonly="true" styles='width:100%' />
                            </td>
                            <td align="right" width="20%">
                                <a title="Click here to show Working Description" href="#" style="text-decoration:none" onClick="OnPopUp('Budget_Description')">Working Description</a></td>
                            <td width="27%">
                                <gw:list id="lstBudget_Description" onchange="" styles='width:100%'></gw:list>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Main Contract Version No</td>
                            <td width="">
                                <gw:list id="lstVersion_No" onchange="" styles='width:100%'></gw:list>
                            </td>
                            <td align="right">
                                Contract Currency</td>
                            <td width="">
                                <gw:list id="lstContract_Ccy" onchange="OnChangeCurrent()" styles='width:100%' />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <a title="Click here to show Change Type" href="#" style="text-decoration:none" onClick="OnPopUp('Revision')">Change Type</a></td>
                            <td width="">
                                <gw:list id="lstRevision_Type" styles='width:100%' />
                            </td>
                            <td align="right">
                                Change Serial No.</td>
                            <td width="">
                                <gw:textbox id="txtRevision_No" styles='width:100%' />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Base Exchange Rate Date</td>
                                		
                                                			<td><gw:datebox id="dtEx_Rate" lang="1" /></td>
                                                           
                            <td align="right">
                                Exchage Rate</td>
                            <td width="">
                                <gw:textbox id="txtEx_Rate" readonly="true" format="#,###,###,###,###,###,###" type="number"  styles='width:100%' />
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Working Period</td>
                            <td width="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <gw:datebox id="dtWorking_Period_Fr" lang="1" />
                                        </td>
                                        <td align="center">
                                            ~</td>
                                        <td width="">
                                            <gw:datebox id="dtWorking_Period_To" lang="1" />
                                        </td>
                                        <td width="100%"></td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right">
                                Contract Period</td>
                            <td width="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <gw:datebox id="dtContract_Period_Fr" lang="1" />
                                        </td>
                                        <td>
                                            ~</td>
                                        <td width="">
                                            <gw:datebox id="dtContract_Period_To" lang="1" />
                                        </td>
                                        <td width="100%"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="">
                                <a title="Click here to show Drafter" href="#" style="text-decoration: none" onClick="OnPopUp('Prepared_By')">
                                    Drafter&nbsp;</a></td>
                            <td width="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td width="40%">
                                            <gw:textbox id="txtPrepared_By_Cd" readonly="true" styles='width:100%' />
                                        </td>
                                        <td width="60%">
                                            <gw:textbox id="txtPrepared_By_Nm" readonly="true" styles='width:100%' />
                                        </td>
                                        <td width="">
                                            <gw:textbox id="txtPrepared_By_Pk" styles='width:100%;display:none' />
                                        </td>
                                        <td>
                                            <gw:imgbtn id="btv7e2" img="reset" alt="Reset" onclick="txtPrepared_By_Cd.text='';txtPrepared_By_Nm.text='';txtPrepared_By_Pk.text='';" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="right"><a title="Target Construction Period" style="color:#333" >
                                Target Const. Per.</a></td>
                            <td width="">
                                <table cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <gw:datebox id="dtWorkingPeriodTarget_Fr" lang="1" />
                                        </td>
                                        <td>
                                            ~</td>
                                        <td width="">
                                            <gw:datebox id="dtWorkingPeriodTarget_To" lang="1" />
                                        </td>
                                        <td width="100%"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">
                                Special Matters</td>
                            <td width="">
                                <gw:textarea id="txtRemark" styles='width:100%;height:50' />
                            </td>
                            <td align="right" valign="top">
                                Compilation Reason</td>
                            <td width="">
                                <gw:textarea id="txtRReasonofRevision" styles='width:100%;height:50' />
                            </td>
                        </tr>
                    </table>
                </fieldset>  
            </td>
        </tr>
        <tr style="height: 50%">
           
                <td width="100%">
                <!--header="0.Description|1.Curr.|2.Key Curr.|3.Corp. Curr. Convr. Exchg Rate|4.Corp. Curr. Convr. Amt|5.Key Curr.|6.Corp. Curr. Convr. Exchg Rate|7.Corp. Curr. Convr. Amt" -->
                                <gw:grid   
                                id="Grid_Contract"  
                                header="Description|Curr.|Key Curr.|Corp. Curr. Convr. Exchg Rate|Corp. Curr. Convr. Amt|Key Curr.|Corp. Curr. Convr. Exchg Rate|Corp. Curr. Convr. Amt"
                                editcol ="0|0|0|0|0|0|0|0"  
                                format="0|0|1|1|1|1|1|1" 
                                aligns="0|0|3|3|3|3|3|3" 
                                defaults="|||||||"
                                widths  ="3000|1000|1000|3000|2500|1000|3000|2500"  
                                styles="width:100%; height:100%"   
                                sorting="T"
                                 />
            		</td>
        </tr>
        <tr style="display:none">
        			<td> <gw:textbox id="txtSerial_No" styles='width:100%;display:none' />
    <gw:textbox id="txtPk" styles='width:100%;display:none' />
  <gw:textbox id="txtTECPS_PERFORMCOSTRMRK_PK"  styles='width:100%;display:none' />
  <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
  <gw:textbox id="txtProject_Pk1" styles='width:100%;display:none' />
  <gw:list id="lstCompany" styles='display:none;width:100%' />
  <gw:textbox id="txt_row"        styles='display:none'/></td>
        </tr>
    </table>
    

</body>
</html>
