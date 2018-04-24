<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Import General Information Data</title>
</head>

<script>
var dept,grp,flag=0;
var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{          
    if (v_language!="ENG")
        System.Translate(document);	
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";    
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); /**/
	var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0024' order by code_nm")%>";
    idGridRelative.SetComboFormat(3,t1);
	t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm")%>";
    idGridBankInfo.SetComboFormat(2,t1);  
	t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0013' order by code_nm")%>";
    idGridInsuranceInfo.SetComboFormat(3,t1); 		
	t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0012' order by code_nm")%>";	
    idGridInsuranceInfo.SetComboFormat(5,t1);   	
    OnLoad();	
}

function OnDataReceive(obj)
{
	if (obj.id=="datDeptData")
	{
		if(txtHr_level.text=="6")
			txtDeptData.text=txtDeptData.text+"|ALL|Select All";
		lstOrg.SetDataText(txtDeptData.text)    ;		
		obj=lstOrg.GetControl();
		if (obj.options.length ==2)
			obj.options.selectedIndex=0;
		else
			obj.options.selectedIndex=0;            
	}  /**/ 
	if(obj.id=="datImpAnnualMon")
	{
		alert("xong roi");
	}
}      

function OnLoad()
{
	
	tblMaternity.style.height="82%";
	tblChild.style.height="0%";
	tblRelative.style.height="0%";
	tblAnnualMonth.style.height="0%";
	tblAnnualDate.style.height="0%";
	tblBankInfo.style.height="0%";
}	

function OnPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj;
        txtUpperDept.text=obj;
        datDeptData.Call();
    }   
}

function OnReport()
{   
	var url;	
	if(	frmimport.option_P[0].checked)
		url=System.RootURL + '/reports/ch/ae/rpt_sample_maternity_list.aspx' ;
	else if(	frmimport.option_P[1].checked)
		url=System.RootURL + '/reports/ch/ae/rpt_sample_children_list.aspx' ;
	else if(	frmimport.option_P[2].checked)
		url=System.RootURL + '/reports/ch/ae/rpt_sample_relative_list.aspx' ;	
	else if(	frmimport.option_P[3].checked)
		url=System.RootURL + '/reports/ch/ae/rpt_sample_bank_info.aspx' ;	
	else if(	frmimport.option_P[4].checked)
		url=System.RootURL + '/reports/ch/ae/rpt_sample_annual_month.aspx' ;	
	else if(	frmimport.option_P[5].checked)
		url=System.RootURL + '/reports/ch/ae/rpt_sample_annual_date.aspx' ;
	else if(	frmimport.option_P[6].checked)
		url=System.RootURL + '/reports/ch/ae/rpt_sample_insurance_info.aspx' ;	
	window.open(url);	
}

function OnSearch()
{
	if(	frmimport.option_P[0].checked)
	{
		datImportMaternity.Call("SELECT");
	}
	else if(	frmimport.option_P[1].checked)
	{
		datImportChild.Call("SELECT");
	}
	else if(	frmimport.option_P[2].checked)
	{
		datImportRelative.Call("SELECT");
	}
	else if(	frmimport.option_P[3].checked)
	{
		datImportBankInfo.Call("SELECT");
	}
	else if(	frmimport.option_P[4].checked)
	{		
		datImpAnnualMon.Call("SELECT");
	}
	else if(	frmimport.option_P[5].checked)
	{		
		datImpAnnualDate.Call("SELECT");
	}
	else if(	frmimport.option_P[6].checked)
	{
		datImportInsuranceInfo.Call("SELECT");
	}
	
}

function OnClick(num)
{
	tblMaternity.style.display="none";
	tblChild.style.display="none";
	tblRelative.style.display="none";
	tblAnnualMonth.style.display="none";
	tblAnnualDate.style.display="none";
	tblBankInfo.style.display="none";
	tblInsuranceInfo.style.display="none";

	if(num==1)
	{
		tblMaternity.style.height="82%";
		tblMaternity.style.display="";
		tblChild.style.height="0%";
		tblRelative.style.height="0%";
		tblAnnualMonth.style.height="0%";
		tblAnnualDate.style.height="0%";
		tblBankInfo.style.height="0%";
		tblInsuranceInfo.style.height="0%";
	}
	else if(num==2)
	{
		tblMaternity.style.height="0%";
		tblChild.style.height="82%";
		tblChild.style.display="";
		tblRelative.style.height="0%";		
		tblBankInfo.style.height="0%";
		tblAnnualMonth.style.height="0%";
		tblAnnualDate.style.height="0%";
		tblInsuranceInfo.style.height="0%";
	}
	else if(num==3)
	{
		tblMaternity.style.height="0%";
		tblChild.style.height="0%";
		tblRelative.style.height="82%";
		tblRelative.style.display="";		
		tblBankInfo.style.height="0%";
		tblAnnualMonth.style.height="0%";
		tblAnnualDate.style.height="0%";
		tblInsuranceInfo.style.height="0%";
	}
	else if(num==4)
	{
		tblMaternity.style.height="0%";
		tblChild.style.height="0%";
		tblRelative.style.height="0%";			
		tblBankInfo.style.height="82%";
		tblBankInfo.style.display="";
		tblAnnualMonth.style.height="0%";
		tblAnnualDate.style.height="0%";
		tblInsuranceInfo.style.height="0%";
		lblYear.styles.display="";
		dbYear.styles.display="";
	}
	else if(num==5)
	{
		tblMaternity.style.height="0%";
		tblChild.style.height="0%";
		tblRelative.style.height="0%";		
		tblBankInfo.style.height="0%";
		tblAnnualMonth.style.height="82%";
		tblAnnualDate.style.height="0%";
		tblAnnualMonth.style.display="";
		tblInsuranceInfo.style.height="0%";
	}	
	else if(num==6)
	{
		tblMaternity.style.height="0%";
		tblChild.style.height="0%";
		tblRelative.style.height="0%";		
		tblBankInfo.style.height="0%";
		tblAnnualMonth.style.height="0%";
		tblAnnualDate.style.height="82%";	
		tblAnnualDate.style.display="";
		tblInsuranceInfo.style.height="0%";
	}
	else if(num==7)
	{
		tblMaternity.style.height="0%";
		tblChild.style.height="0%";
		tblRelative.style.height="0%";		
		tblBankInfo.style.height="0%";
		tblAnnualMonth.style.height="0%";
		tblAnnualDate.style.height="0%";			
		tblInsuranceInfo.style.height="82%";
		tblInsuranceInfo.style.display="";
	}
}

function OnShowPopup(code)
{
	var fpath, obj;
	if(code!='HR0013')
	{
		fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" +  code ;        
		System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	}
	else
	{
		fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" +  code ;        
		System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
		alert('Now input Health Place');
		fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" +  'HR0012' ;        
		System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	}
	
}

function CheckValidFile(vfile)
{
    var sext;
    sext=vfile.substring(vfile.length-4,vfile.length);
    if (sext!=".xls")
        return false;
    return true;
}

function OnLoadExcel()
{	
	var vfilename = document.all["inputfile"].value;    
	if (!CheckValidFile(vfilename) || vfilename =="")
	{
		alert("Please select excel file");
		return;
	}	
	if(	frmimport.option_P[0].checked)
	{
		ImportMaternity();
	}
	else if(frmimport.option_P[1].checked)
	{
		ImportChild();
	}
	else if(frmimport.option_P[2].checked)
	{
		ImportRelative();
	}
	else if(frmimport.option_P[3].checked)
	{
		ImportBankInfo();
	}
	else if(frmimport.option_P[4].checked)
	{		
		ImportAnnualMonth();
	}
	else if(frmimport.option_P[5].checked)
	{		
		ImportAnnualDate();
	}
	else if(frmimport.option_P[6].checked)
	{
		ImportInsuranceInfo();
	}
}

function ImportMaternity()
{
	idGridMaternity.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, vstart_date, vend_date;
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vstart_date=workSheet.Cells(j,4).value;
			vend_date=workSheet.Cells(j,5).value;						
			if (vemp_id=="" )
			   alert("Emp-ID cannot be blank at row: " + j );
			else if (vemp_name=="")
				alert("Name cannot be blank at row: " + j);
			else if (vstart_date=="" || !isDate(vstart_date) )
				alert("Invalid Start date at row: " + j + " in excell file");            
			else if(vend_date=="" || !isDate(vend_date))
				alert("Invalid End date at row: " + j + " in excell file");           
			else
			{                             
				idGridMaternity.AddRow();
				var irow=idGridMaternity.rows-1;
				idGridMaternity.SetGridText(irow,0,vemp_id);
				idGridMaternity.SetGridText(irow,1,vemp_name);				
				idGridMaternity.SetGridText(irow,2,vstart_date);                    
				idGridMaternity.SetGridText(irow,3,vend_date);                    
			}			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}	
}

function ImportChild()
{
	idGridChild.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, vstart_date, vend_date,vchild_name,vbirth_date;
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vchild_name=workSheet.Cells(j,4).value;
			vbirth_date=workSheet.Cells(j,5).value;
			vstart_date=workSheet.Cells(j,6).value;
			vend_date=workSheet.Cells(j,7).value;						
			if (vemp_id=="" )
			   alert("Emp-ID cannot be blank at row: " + j);
			else if (vemp_name=="")
				alert("Name cannot be blank at row: " + j);
			else if (vstart_date=="" || !isDate(vstart_date) )
				alert("Invalid Start date at row: " + j);   			
			else if(vchild_name=="" )
				alert("Child's name cannot be blank at row: " + j); /**/
			else
			{                             
				idGridChild.AddRow();
				var irow=idGridChild.rows-1;
				idGridChild.SetGridText(irow,0,vemp_id);
				idGridChild.SetGridText(irow,1,vemp_name);				
				idGridChild.SetGridText(irow,2,vchild_name);                    
				idGridChild.SetGridText(irow,3,vbirth_date);                    
				idGridChild.SetGridText(irow,4,vstart_date);                    
				idGridChild.SetGridText(irow,5,vend_date);                    
			}			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}	
}

function ImportRelative()
{
	idGridRelative.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, vstart_date, vend_date,vrelative_name,vrelative_code;
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vrelative_name=workSheet.Cells(j,4).value;
			vrelative_code=workSheet.Cells(j,5).value;
			vstart_date=workSheet.Cells(j,6).value;
			vend_date=workSheet.Cells(j,7).value;									
			if (vemp_id=="" )
			   alert("Emp-ID cannot be blank at row: " + j);
			else if (vemp_name=="")
				alert("Name cannot be blank at row: " + j);
			else if (vstart_date=="" || !isDate(vstart_date) )
				alert("Invalid Start date at row: " + j);
			else if(vrelative_name=="" )
				alert("Relative's name cannot be blank at row: " + j); 
			else if(vrelative_code=="" )
				alert("Relative code cannot be blank at row: " + j); 					
			else
			{                             
				idGridRelative.AddRow();
				var irow=idGridRelative.rows-1;
				idGridRelative.SetGridText(irow,0,vemp_id);
				idGridRelative.SetGridText(irow,1,vemp_name);				
				idGridRelative.SetGridText(irow,2,vrelative_name);                    
				idGridRelative.SetGridText(irow,3,vrelative_code);                    
				idGridRelative.SetGridText(irow,4,vstart_date);                    
				idGridRelative.SetGridText(irow,5,vend_date);                    
			}			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}	
}

function ImportBankInfo()
{
	idGridBankInfo.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, vaccount_number,vbank_code;
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vbank_code=workSheet.Cells(j,4).value;
			vaccount_number=workSheet.Cells(j,5).value;								
			if (vemp_id=="" )
			   alert("Emp-ID cannot be blank at row: " + j);
			else if (vemp_name=="")
				alert("Name cannot be blank at row: " + j);
			else if (vaccount_number=="" )
				alert("Account number cannot be blank at row: " + j);            
			else if(vbank_code=="" )
				alert("Account code cannot be blank at row: " + j); 
			else
			{                             
				idGridBankInfo.AddRow();
				var irow=idGridBankInfo.rows-1;
				idGridBankInfo.SetGridText(irow,0,vemp_id);
				idGridBankInfo.SetGridText(irow,1,vemp_name);				
				idGridBankInfo.SetGridText(irow,2,vbank_code);                    
				idGridBankInfo.SetGridText(irow,3,vaccount_number);                    				                 
			}			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}	
}

function ImportAnnualMonth()
{
	idGridAnnualMonth.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, v01,v02,v03,v04,v05,v06,v07,v08,v09,v10,v11,v12;
		var maxRow =workSheet.UsedRange.Rows.Count;	
		if	(maxRow>500)
		{
			alert("Import 500 records per each time,divide it to "+ Math.ceil(maxRow/500) + " times");
			return;
		}
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;			
			v01=workSheet.Cells(j,4).value;									
			v02=workSheet.Cells(j,5).value;			
			v03=workSheet.Cells(j,6).value;			
			v04=workSheet.Cells(j,7).value;			
			v05=workSheet.Cells(j,8).value;			
			v06=workSheet.Cells(j,9).value;		
			v07=workSheet.Cells(j,10).value;			
			v08=workSheet.Cells(j,11).value;		
			v09=workSheet.Cells(j,12).value;			
			v10=workSheet.Cells(j,13).value;			
			v11=workSheet.Cells(j,14).value;			
			v12=workSheet.Cells(j,15).value;			
			if (vemp_id=="" )
			{
				alert("Emp-ID cannot be blank at row: " + j );
				return;
			}
			else if (vemp_name=="")
				alert("Name cannot be blank at row: " + j);			        
			else
			{                             
				idGridAnnualMonth.AddRow();
				var irow=idGridAnnualMonth.rows-1;
				idGridAnnualMonth.SetGridText(irow,0,vemp_id);
				idGridAnnualMonth.SetGridText(irow,1,vemp_name);								                
				idGridAnnualMonth.SetGridText(irow,2,v01);                    
				idGridAnnualMonth.SetGridText(irow,3,v02);
				idGridAnnualMonth.SetGridText(irow,4,v03);
				idGridAnnualMonth.SetGridText(irow,5,v04);
				idGridAnnualMonth.SetGridText(irow,6,v05);
				idGridAnnualMonth.SetGridText(irow,7,v06);
				idGridAnnualMonth.SetGridText(irow,8,v07);
				idGridAnnualMonth.SetGridText(irow,9,v08);
				idGridAnnualMonth.SetGridText(irow,10,v09);
				idGridAnnualMonth.SetGridText(irow,11,v10);
				idGridAnnualMonth.SetGridText(irow,12,v11);
				idGridAnnualMonth.SetGridText(irow,13,v12);
				idGridAnnualMonth.SetGridText(irow,14,idDBYear.value);
			}				
		}		
		myApp.Quit();/**/
	}
	catch(e)
	{
		alert(e.Message); 
	}
}

function ImportAnnualDate()
{
	idGridAnnualDate.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, vabs_date, vhours
		var maxRow =workSheet.UsedRange.Rows.Count; 		  
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vabs_date=workSheet.Cells(j,4).value;
			vhours=workSheet.Cells(j,5).value;
								
			if (vemp_id=="" )
			   alert("Emp-ID cannot be blank at row: " + j);
			else if (vemp_name=="")
				alert("Name cannot be blank at row: " + j);
			else if (vabs_date==""  )
				alert("Invalid Date at row: " + j );   			
			else if(vhours=="" || vhours>8 )
				alert("Invalid number at row: " + j + " Emp-ID: "+ vemp_id); /**/
			else
			{                             
				idGridAnnualDate.AddRow();
				var irow=idGridAnnualDate.rows-1;
				idGridAnnualDate.SetGridText(irow,0,vemp_id);
				idGridAnnualDate.SetGridText(irow,1,vemp_name);				
				idGridAnnualDate.SetGridText(irow,2,vabs_date);                    
				idGridAnnualDate.SetGridText(irow,3,vhours);                    				                 
			}			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}
}

function ImportInsuranceInfo()
{
	idGridInsuranceInfo.ClearData();	
	try
	{
		var vfilename = document.all["inputfile"].value;    
		var myApp = new ActiveXObject("Excel.Application");     
		myApp.Workbooks.Open(vfilename); 
		var workSheet = myApp.ActiveSheet; 
		var vemp_id,vemp_name, vsocial_no,vsocial_code,vhealth_no, vhealth_code,vunemp_yn,vunion_yn;
		var maxRow =workSheet.UsedRange.Rows.Count; 
		var check_1=0;
		var check_2=0;
		for (var j =3;j <= maxRow; j++) 
		{ 
			vemp_id=workSheet.Cells(j,2).value;                        
			vemp_name=workSheet.Cells(j,3).value;
			vsocial_no=workSheet.Cells(j,4).value;
			vsocial_code=workSheet.Cells(j,5).value;
			vhealth_no=workSheet.Cells(j,6).value;                        
			vhealth_code=workSheet.Cells(j,7).value;
			vunemp_yn=workSheet.Cells(j,8).value;
			vunion_yn=workSheet.Cells(j,9).value;						
			check_1 = (vunemp_yn="Y") ? -1 : 0;
			check_2 = (vunion_yn="Y") ? -1 : 0;
			if (vemp_id=="" )
			   alert("Emp-ID cannot be blank at row: " + j);
			else if (vemp_name=="")
				alert("Name cannot be blank at row: " + j);			
			else
			{                             
				idGridInsuranceInfo.AddRow();
				var irow=idGridInsuranceInfo.rows-1;
				idGridInsuranceInfo.SetGridText(irow,0,vemp_id);
				idGridInsuranceInfo.SetGridText(irow,1,vemp_name);				
				idGridInsuranceInfo.SetGridText(irow,2,vsocial_no);                    
				idGridInsuranceInfo.SetGridText(irow,3,vsocial_code);  
				idGridInsuranceInfo.SetGridText(irow,4,vhealth_no);
				idGridInsuranceInfo.SetGridText(irow,5,vhealth_code);				
				idGridInsuranceInfo.SetGridText(irow,6,check_1);                    
				idGridInsuranceInfo.SetGridText(irow,7,check_2);  
			}			
		} 
		myApp.Quit();
	}
	catch(e)
	{
		alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
	}	
}

function OnSave()
{
	
    if(	frmimport.option_P[0].checked)
	{
		datImportMaternity.Call();		
	}
	else if(frmimport.option_P[1].checked)
	{
		datImportChild.Call();
	}
	else if(frmimport.option_P[2].checked)
	{
		datImportRelative.Call();
	}
	else if(frmimport.option_P[3].checked)
	{
		datImportBankInfo.Call();
	}
	else if(frmimport.option_P[4].checked)
	{
		datImpAnnualMon.Call();
	}	
	else if(frmimport.option_P[6].checked)
	{
		datImportInsuranceInfo.Call();
	}
	
}

function isInteger(s)
{
	var i;
    for (i = 0; i < s.length; i++)
	{   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag)
{
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++)
	{   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year)
{
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n) 
{
	for (var i = 1; i <= n; i++) 
	{
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr)
{
	//if(dtStr=="")
	//	return true;
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf("/")
	var pos2=dtStr.indexOf("/",pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) 
	{
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		//alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12)
	{
		//alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month])
	{
		//alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<1900 || year>2100)
	{
		//alert("Please enter a valid 4 digit year between "+1900+" and "+2100)
		return false
	}
	if (dtStr.indexOf("/",pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, "/"))==false)
	{
		//alert("Please enter a valid date")
		return false
	}
	return true
}

</script>

<body>
<!------------main control---------------------->
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportMaternity" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3" function="hr.sp_sel_imp_maternity" procedure="hr.sp_pro_imp_maternity" > 
                <input bind="idGridMaternity" >
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
                </input>
                <output  bind="idGridMaternity" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportChild" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4,5" function="hr.sp_sel_imp_child" procedure="hr.sp_pro_imp_child"> 
                <input bind="idGridChild" >  
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
                </input>
                <output  bind="idGridChild" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportRelative" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4,5" function="hr.sp_sel_imp_relative" procedure="hr.sp_pro_imp_relative"> 
                <input bind="idGridRelative" > 
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
                </input>
                <output  bind="idGridRelative" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportBankInfo" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3" function="hr.sp_sel_imp_bank_info" procedure="hr.sp_pro_imp_bank_info"> 
                <input bind="idGridBankInfo" >  
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
                </input>
                <output  bind="idGridBankInfo" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportInsuranceInfo" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4,5,6,7" function="hr.sp_sel_imp_insurance_info" procedure="hr.sp_pro_imp_insurance_info"> 				
                <input bind="idGridInsuranceInfo" >  
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
                </input>
                <output  bind="idGridInsuranceInfo" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImpAnnualMon" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,2,3,4,5,6,7,8,9,10,11,12,13,14" function="hr.sp_sel_imp_ale_mon" procedure="hr.sp_pro_imp_ale_mon">
                <input bind="idGridAnnualMonth" >
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
					<input bind="idDBYear" />
                </input>                 
                <output bind="idGridAnnualMonth" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImpAnnualDate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,2,3" function="hr.sp_sel_imp_ale_date" procedure="hr.sp_pro_imp_ale_date">
                <input bind="idGridAnnualDate" >
					<input bind="lstOrg" />
					<input bind="lstWG" />
					<input bind="lstStatus" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
					<input bind="idDBYear" />
                </input>                 
                <output bind="idGridAnnualDate" />                
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table--------------------------------->

<form name="frmimport" id="form2"  > 
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:18%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
				<tr style="height:6%;border:0">	
					<td align=center colspan=2 style="width:4%" >
						<a title="Click here to show Organization" onclick="OnPopup()" href="#tips" >Oganization</a>
					</td>
		            <td align=left colspan=11 style="width:22%" >
						<gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeOrg()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list></td>					            	
					<td align=center colspan=3 style="width:6%" >W-Group</td>
		            <td align=left colspan=10 style="width:20%" >
						<gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data>
						</gw:list>
					</td>					
			
					<td align=right colspan=4 style="width:8%" >Status</td>
		            <td align=left colspan=6 style="width:12%" >
						<gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
					</td>
			
					<td align=right colspan=3 style="width:6%" >Search by</td>
		            <td align=center colspan=5 style="width:10%" >
						<gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
						</gw:list>
					</td>
					<td align=left colspan=5 style="width:10%" >
						<gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:95%"/>
					</td>
					<td align=center colspan=1 style="width:2%" ></td>
		            								
				</tr>
				
	            <tr style="height:6%;border:0">	
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idMaternity" name="option_P" value="1" checked onclick="OnClick(1)" ></td>
		            <td align=left colspan=6 style="width:12%" >Maternity List</td>
			
		            <td align=left colspan=1 style="width:2%" ><input type="radio" id="idChild" name="option_P" value="2"  onclick="OnClick(2)" ></td>
		            <td align=left colspan=6 style="width:12%" >Children List</td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idRelative" name="option_P" value="3"  onclick="OnClick(3)" ></td>
		            <td align=left colspan=6 style="width:12%" ><a title="Click to input Ralative Code" onclick="OnShowPopup('HR0024')" href="#tips" >Relative List</a></td>					
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idBankInfo" name="option_P" value="4"  onclick="OnClick(4)" ></td>
		            <td align=left colspan=6 style="width:12%" ><a title="Click to input Bank Code" onclick="OnShowPopup('HR0020')" href="#tips" >Bank Info</a> </td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idAnnualMonth" name="option_P" value="5"  onclick="OnClick(5)" ></td>
		            <td align=left colspan=6 style="width:12%" >Annual by Month</td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idAnnualDay" name="option_P" value="6"  onclick="OnClick(6)" ></td>
		            <td align=left colspan=6 style="width:12%" >Annual by Date</td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idInsuranceInfo" name="option_P" value="7"  onclick="OnClick(7)" ></td>
		            <td align=left colspan=5 style="width:10%" ><a title="Click to input Social & Health Place" onclick="OnShowPopup('HR0013')" href="#tips" >Insurance Info</a></td>
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>					
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn img="excel" id="ibtn7"    alt="Sample Reports"  onclick="OnReport()"/></td>					
				</tr>
				
				<tr style="height:6%;border:0">
					<td align=left colspan=1 style="width:2%" ></td>
		            <td align=left colspan=6 style="width:12%" ></td>
			
		            <td align=left colspan=1 style="width:2%" ></td>
		            <td align=left colspan=6 style="width:12%" ></td>
			
					<td align=left colspan=1 style="width:2%" >
						Year
					</td>
		            <td align=left colspan=6 style="width:12%" >
						<gw:datebox id="idDBYear" type="year" />						
					</td>					
			
					<td align=left colspan=1 style="width:2%" ></td>		            
			
					<td align=right colspan=6 style="width:12%" >Excell file</td>									
					<td align=left colspan=20 style="width:40%" ><input id="inputfile" type="file" name="pic" size="60"  accept="text/csv,text/xls"></td>
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell to Grid"  onclick="OnLoadExcel()"/></td>
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnSave()" /></td>
		          <!-- -->
					
				</tr>
				                                
	        </table>
			
	        <table id="tblMaternity" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridMaternity"  
				        header="EmpID|Full Name|Start DT|End DT"   
				        format="0|0|0|0"  
				        aligns="1|1|1|1"  
				        defaults="||||"  
				        editcol="0|0|0|0"  
				        widths="2500|3500|2500|2500"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblChild" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridChild"  
				        header="EmpID|Employee's Name|Employee Child's Name|Birth Date|Start DT|End DT"   
				        format="0|0|0|0|0|0"  
				        aligns="1|1|1|1|0|0"  
				        defaults="||||||"  
				        editcol="0|0|0|0|0"  
				        widths="1500|3000|3000|2000|2000|2000"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblRelative" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridRelative"  
				        header="EmpID|Employee's Name|Name of Relative|Relation|Start DT|End DT"   
				        format="0|0|0|0|0"  
				        aligns="1|1|1|1|1"  
				        defaults="|||||"  
				        editcol="0|0|0|0|0"  
				        widths="1500|3500|3500|2300|2000|2000"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>	    		
			
			<table id="tblBankInfo" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridBankInfo"  
				        header="EmpID|Full Name|Bank Type|Account Number"   
				        format="0|0|0|0"  
				        aligns="1|1|1|1"  
				        defaults="||||"  
				        editcol="0|0|0|0"  
				        widths="2500|3500|2500|2500|"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblAnnualMonth" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridAnnualMonth"  
				        header="EmpID|Full Name|01|02|03|04|05|06|07|08|09|10|11|12|Year"   
				        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				        aligns="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
				        defaults="|||||||||||||||"  
				        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				        widths="1500|3000|700|700|700|700|700|700|700|700|700|700|700|700|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblAnnualDate" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridAnnualDate"  
				        header="EmpID|Full Name|Absent Date|Absent Hours"   
				        format="0|0|0|0"  
				        aligns="1|1|1|1"  
				        defaults="||||"  
				        editcol="0|0|0|0"  
				        widths="2500|3500|2500|2500"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblInsuranceInfo" style="width:100%;height:82%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridInsuranceInfo"  
				        header="EmpID|Full Name|Social No|Social Place|Health No|Health Place|UnEmp Y/N|Union Y/N"   
				        format="0|0|0|0|0|0|3|3"  
				        aligns="1|1|1|1|1|1|1|1 
				        defaults="||||||||
				        editcol="0|0|0|0|0|0|0|0"
				        widths="1000|3000|2000|2500|2000|2500|1500|1500"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
		<gw:textbox id="iduser_pk" styles="display:none"/>
		<gw:textbox id="txtHr_level" styles="display:none"/>
		<gw:textbox id="txtDeptData" styles="display:none"/>
		<gw:textbox id="txtUpperDept" styles="display:none"/>
		<gw:textbox id="txtGroupData" styles="display:none"/>
		<gw:textbox id="txtMonth" styles="display:none"/>
		<gw:textbox id="txtAleDays" styles="display:none"/>
		<gw:textbox id="txtEmpID" styles="display:none"/>
		<gw:textbox id="txtResult" styles="display:none"/>
		</td>	
		</tr>
</table>
	
</form>
   
</body>
</html>
