<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Import General Information Data</title>
</head>

<script>
    var dept, grp, flag = 0;
    var v_language = "<%=Session("SESSION_LANG")%>";
var imp_seq;

var insur_sal_flag = 0;
var check_init = 0;

function BodyInit() {
    if (v_language != "ENG")
        System.Translate(document);

    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text = "<%=session("HR_LEVEL")%>";
    idDBUSR.text = "<%=session("APP_DBUSER")%>";

    insur_sal_flag = "<%=ESysLib.SetDataSQL("select nvl(num_3,0) from vhr_hr_code where id='HR0006' and code='14'")%>";
    //alert(insur_sal_flag);
    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0024' order by code_nm")%>";
    idGridRelative.SetComboFormat(4, t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm")%>";
    idGridBankInfo.SetComboFormat(2, t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm")%>";
    idGridBankInfo.SetComboFormat(4, t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0013' order by code_nm")%>";
    idGridInsuranceInfo.SetComboFormat(3, t1);
    t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0012' order by code_nm")%>";
    idGridInsuranceInfo.SetComboFormat(5, t1);

    t1 = "#Y;YES|#N;NO|#;";
    idGridInsuranceInfo.SetComboFormat(6, t1);

    t1 = "#Y;YES|#N;NO|#;";
    idGridInsuranceInfo.SetComboFormat(7, t1);

    OnLoad();

    menu_id.text = System.Menu.GetMenuID();
    datCheck_View.Call();
}

function OnDataReceive(obj) {
    switch (obj.id) {
        case "datCheck_View":
            if (txtFlag_View.text == 'Y')
                ibtnUpdate.style.display = "none";

            check_init = 1;
            break;

        case "datImportResigned":
            lblRecord.text = idGridResigned.rows - 1 + " record(s).";
            break;
        case "datImportMaternity":
            lblRecord.text = idGridMaternity.rows - 1 + " record(s).";
            break;
        case "datImportChild":
            lblRecord.text = idGridChild.rows - 1 + " record(s).";
            break;
        case "datImportRelative":
            lblRecord.text = idGridRelative.rows - 1 + " record(s).";
            break;
        case "datImportBankInfo":
            lblRecord.text = idGridBankInfo.rows - 1 + " record(s).";
            break;
        case "datImpAnnualMon":
            lblRecord.text = idGridAnnualMonth.rows - 1 + " record(s).";
            break;
        case "datImportInsuranceInfo":
            lblRecord.text = idGridInsuranceInfo.rows - 1 + " record(s).";
            break;
        case "datImportUnion":
            lblRecord.text = idGridUnion.rows - 1 + " record(s).";
            break;
    }
}

function OnLoad() {
    tblMaternity.style.height = "90%";
    tblChild.style.height = "0%";
    tblRelative.style.height = "0%";
    tblAnnualMonth.style.height = "0%";
    tblAnnualDate.style.height = "0%";
    tblBankInfo.style.height = "0%";
}

function OnReport() {
    if (check_init == 1) {
        var url;
        if (frmimport.option_P[0].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_resigned.aspx';
        else if (frmimport.option_P[1].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_maternity_list.aspx';
        else if (frmimport.option_P[2].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_children_list.aspx';
        else if (frmimport.option_P[3].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_relative_list.aspx';
        else if (frmimport.option_P[4].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_bank_info.aspx';
        else if (frmimport.option_P[5].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_annual_month.aspx';
        else if (frmimport.option_P[6].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_annual_date.aspx';
        else if (frmimport.option_P[7].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_insurance_info.aspx?p_insur_sal_flag=' + insur_sal_flag;
        else if (frmimport.option_P[8].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_union_info.aspx';
        else if (frmimport.option_P[9].checked)
            url = System.RootURL + '/reports/ch/ae/rpt_sample_pit_info.aspx';

        window.open(url);
    }
}

function OnSearch() {
    if (check_init == 1) {
        if (frmimport.option_P[0].checked) {
            datImportResigned.Call("SELECT");
        }
        else if (frmimport.option_P[1].checked) {
            datImportMaternity.Call("SELECT");
        }
        else if (frmimport.option_P[2].checked) {
            datImportChild.Call("SELECT");
        }
        else if (frmimport.option_P[3].checked) {
            datImportRelative.Call("SELECT");
        }
        else if (frmimport.option_P[4].checked) {
            datImportBankInfo.Call("SELECT");
        }
        else if (frmimport.option_P[5].checked) {
            datImpAnnualMon.Call("SELECT");
        }
        else if (frmimport.option_P[6].checked) {
            datImpAnnualDate.Call("SELECT");
        }
        else if (frmimport.option_P[7].checked) {
            datImportInsuranceInfo.Call("SELECT");
        }
        else if (frmimport.option_P[8].checked) {
            datImportUnion.Call("SELECT");
        }
        else if (frmimport.option_P[9].checked) {
            datImportPit.Call("SELECT");
        }
    }
}

function OnClick(num) {
    if (check_init == 1) {
        imp_seq = new Date().getTime();
        txtSequence.text = imp_seq;
        lblRecord.text = "0 record(s)";
        tblMaternity.style.display = "none";
        tblChild.style.display = "none";
        tblRelative.style.display = "none";
        tblAnnualMonth.style.display = "none";
        tblAnnualDate.style.display = "none";
        tblBankInfo.style.display = "none";
        tblInsuranceInfo.style.display = "none";
        tblUnion.style.display = "none";
        tblPit.style.display = "none";

        if (num == 1) {
            tblResigned.style.height = "90%";
            tblResigned.style.display = "";
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblRelative.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            tblPit.style.height = "0%";
        }
        else if (num == 2) {
            tblMaternity.style.height = "90%";
            tblMaternity.style.display = "";
            tblResigned.style.height = "0%";
            tblChild.style.height = "0%";
            tblRelative.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            tblPit.style.height = "0%";
        }
        else if (num == 3) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "90%";
            tblResigned.style.height = "0%";
            tblChild.style.display = "";
            tblRelative.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            tblPit.style.height = "0%";
        }
        else if (num == 4) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblResigned.style.height = "0%";
            tblRelative.style.height = "90%";
            tblRelative.style.display = "";
            tblBankInfo.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            tblPit.style.height = "0%";
        }
        else if (num == 5) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblResigned.style.height = "0%";
            tblRelative.style.height = "0%";
            tblBankInfo.style.height = "90%";
            tblBankInfo.style.display = "";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            idDBYear.style.display = "";
            tblPit.style.height = "0%";
        }
        else if (num == 6) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblResigned.style.height = "0%";
            tblRelative.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblAnnualMonth.style.height = "90%";
            tblAnnualDate.style.height = "0%";
            tblAnnualMonth.style.display = "";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            tblPit.style.height = "0%";
        }
        else if (num == 7) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblResigned.style.height = "0%";
            tblRelative.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "90%";
            tblAnnualDate.style.display = "";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            tblPit.style.height = "0%";
        }
        else if (num == 8) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblResigned.style.height = "0%";
            tblRelative.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblInsuranceInfo.style.height = "90%";
            tblInsuranceInfo.style.display = "";
            tblUnion.style.height = "0%";
            tblPit.style.height = "0%";
        }
        else if (num == 9) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblResigned.style.height = "0%";
            tblRelative.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "90%";
            tblUnion.style.display = "";
            tblPit.style.height = "0%";
        }
        else if (num == 10) {
            tblMaternity.style.height = "0%";
            tblChild.style.height = "0%";
            tblResigned.style.height = "0%";
            tblRelative.style.height = "0%";
            tblBankInfo.style.height = "0%";
            tblAnnualMonth.style.height = "0%";
            tblAnnualDate.style.height = "0%";
            tblInsuranceInfo.style.height = "0%";
            tblUnion.style.height = "0%";
            tblPit.style.height = "90%";
            tblPit.style.display = "";
        }
    }
}

function OnShowPopup(code) {
    if (check_init == 1) {
        var fpath, obj;
        fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" + code;
        System.OpenModal(fpath, 800, 600, 'resizable:yes;status:yes');
    }
}

function CheckValidFile(vfile) {
    var sext, sext2;
    sext = vfile.substring(vfile.length - 4, vfile.length);
    sext1 = vfile.substring(vfile.length - 5, vfile.length);
    if (sext != ".xls" && sext1 != ".xlsx")
        return false;
    return true;
}

function OnImportNew() {
    if (check_init == 1) {
        var currentTime = new Date();
        var p_cols;
        txtSequence.text = currentTime.getTime();

        // argument fixed table_name, procedure, procedure_file
        // dynamic arg p_1,p_2,p_3,p_4,p_5

        if (frmimport.option_P[0].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_RESIGNED";
            p_cols = 6;
        }
            //ImportResigned();
        else if (frmimport.option_P[1].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_MATERNITY";
            p_cols = 5;
        }
            //ImportMaternity();
        else if (frmimport.option_P[2].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_CHILD";
            p_cols = 7;
        }
            //ImportChild();              
        else if (frmimport.option_P[3].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_RELATIVE";
            p_cols = 9;
        }
            //ImportRelative();
        else if (frmimport.option_P[4].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_BANK";
            p_cols = 6;
        }
            //ImportBankInfo();
        else if (frmimport.option_P[5].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_ALE_MON";
            p_cols = 15;
        }
            //ImportAnnualMonth();
        else if (frmimport.option_P[6].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_ALE_DATE";
            p_cols = 5;
        }
            //ImportAnnualDate();
        else if (frmimport.option_P[7].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_INSURANCE";
            p_cols = 11;
        }
            //ImportInsuranceInfo();    
        else if (frmimport.option_P[8].checked) {
            txtProcedure.text = "HR_UPD_10010022_IMP_UNION";
            p_cols = 5;
        }
        else if (frmimport.option_P[9].checked) {
            txtProcedure.text = "HR_UPD_10010022_PIT";
            p_cols = 4;
        }
        //ImportUnion();

        var url = System.RootURL + '/system/binary/ReadExcel.aspx?import_seq=' + txtSequence.text + '&p_err_cont=N' + '&table_name=TES_FILEOBJECT' + '&procedure=GASP.SP_INSERT_IMAGE' + '&procedure_file=' + idDBUSR.text + '.' + txtProcedure.text + '&p_cols=' + p_cols + '&p_1=' + idDBYear.value + '&p_2=' + insur_sal_flag + '&p_3=' + '&p_4=' + '&p_5=';
		
        lblRecord.text = System.OpenModal(url, 415, 100, "unadorned:on ; center:yes; edge:sunken ; resizable:yes;status:yes;");

        if (lblRecord.text != 'undefined') {
            alert("Imported : " + lblRecord.text + " record(s)");
        }

        OnSearch();
    }
}

function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary(year) {
    // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
}

function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this
}

function isDate(dtStr) {

    if (dtStr == "")
        return false;
    var daysInMonth = DaysArray(12)
    var pos1 = dtStr.indexOf("/")
    var pos2 = dtStr.indexOf("/", pos1 + 1)
    var strDay = dtStr.substring(0, pos1)
    var strMonth = dtStr.substring(pos1 + 1, pos2)
    var strYear = dtStr.substring(pos2 + 1)
    strYr = strYear
    if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
    if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
    }
    month = parseInt(strMonth)
    day = parseInt(strDay)
    year = parseInt(strYr)
    if (pos1 == -1 || pos2 == -1) {
        //alert("The date format should be : dd/mm/yyyy")
        return false
    }
    if (strMonth.length < 1 || month < 1 || month > 12) {
        //alert("Please enter a valid month")
        return false
    }
    if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
        //alert("Please enter a valid day")
        return false
    }
    if (strYear.length != 4 || year == 0 || year < 1900 || year > 2100) {
        //alert("Please enter a valid 4 digit year between "+1900+" and "+2100)
        return false
    }
    if (dtStr.indexOf("/", pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, "/")) == false) {
        //alert("Please enter a valid date")
        return false
    }
    return true
}

</script>

<body>
<!------------main control---------------------->
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datImportMaternity" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4" function="hr_sel_10010022_imp_maternity" procedure="" > 
                <input bind="idGridMaternity" >
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridMaternity" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datImportResigned" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,4,5" function="hr_sel_10010022_imp_resigned" procedure="" > 
                <input bind="idGridResigned" >
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridResigned" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datImportChild" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4,5,6" function="hr_sel_10010022_imp_child" procedure=""> 
                <input bind="idGridChild" >  
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridChild" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportRelative" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4,5,6,7,8" function="hr_sel_10010022_imp_relative" procedure=""> 
                <input bind="idGridRelative" > 
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridRelative" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportBankInfo" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4,5" function="hr_sel_10010022_imp_bank" procedure=""> 
                <input bind="idGridBankInfo" >  
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridBankInfo" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportInsuranceInfo" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,4,5,6,7,8,9" function="hr_sel_10010022_imp_insurance" procedure=""> 				
                <input bind="idGridInsuranceInfo" >  
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridInsuranceInfo" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportUnion" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,5,6,7" function="hr_sel_10010022_imp_union" procedure="">
                <input bind="idGridUnion" >  
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridUnion" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImportPit" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="hr_sel_10010022_pit" procedure="">
                <input bind="idGridPit" >  
					<input bind="txtSequence" />
                </input>
                <output  bind="idGridPit" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImpAnnualMon" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="hr_sel_10010022_imp_ale_mon" procedure="">
                <input bind="idGridAnnualMonth" >
					<input bind="txtSequence" />
					<input bind="idDBYear" />
                </input>                 
                <output bind="idGridAnnualMonth" />                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datImpAnnualDate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,2,3,4" function="hr_sel_10010022_imp_ale_date" procedure="">
                <input bind="idGridAnnualDate" >
					<input bind="txtSequence" />
					
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
	        <table style="width:100%;height:10%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
				
	            <tr style="height:6%;border:0">	
	                <td align=left colspan=1 style="width:2%" ><input type="radio" id="Radio1" name="option_P" value="1" checked onclick="OnClick(1)" ></td>
		            <td align=left colspan=6 style="width:9%" ><a title="Click to input Bank Code" onclick="OnShowPopup('HR0004')" href="#tips" >Resigned Emp</a></td>
		            
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idMaternity" name="option_P" value="2"  onclick="OnClick(2)" ></td>
		            <td align=left colspan=6 style="width:9%" >Maternity List</td>
			
		            <td align=left colspan=1 style="width:2%" ><input type="radio" id="idChild" name="option_P" value="3"  onclick="OnClick(3)" ></td>
		            <td align=left colspan=6 style="width:9%" >Children List</td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idRelative" name="option_P" value="4"  onclick="OnClick(4)" ></td>
		            <td align=left colspan=6 style="width:9%" ><a title="Click to input Ralative Code" onclick="OnShowPopup('HR0024')" href="#tips" >Relative List</a></td>					
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idBankInfo" name="option_P" value="5"  onclick="OnClick(5)" ></td>
		            <td align=left colspan=6 style="width:8%" ><a title="Click to input Bank Code" onclick="OnShowPopup('HR0020')" href="#tips" >Bank Info</a> </td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idAnnualMonth" name="option_P" value="6"  onclick="OnClick(6)" ></td>
		            <td align=left colspan=6 style="width:9%" >Annual by Month</td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idAnnualDay" name="option_P" value="7"  onclick="OnClick(7)" ></td>
		            <td align=left colspan=6 style="width:9%" >Annual by Date</td>
			
					<td align=left colspan=1 style="width:2%" ><input type="radio" id="idInsuranceInfo" name="option_P" value="8"  onclick="OnClick(8)" ></td>
		            <td align=left colspan=5 style="width:18%" ><a title="Click to input Social & Health Place" onclick="OnShowPopup('HR0013')" href="#tips" >Social </a> & <a title="Click to input Social & Health Place" onclick="OnShowPopup('HR0012')" href="#tips" >Health </a> </td>
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>					
					<td align=left colspan=1 style="width:2%" ><gw:imgBtn img="excel" id="ibtn7"    alt="Sample Reports"  onclick="OnReport()"/></td>					
				</tr>
				
				<tr style="height:6%;border:0">
					<td align=left colspan=1 style="width:2%;" ><input type="radio" id="idUnion" name="option_P" value="9"  onclick="OnClick(9)" ></td>
		            <td align=left colspan=6 style="width:9%;" >Union</td>
					
					<td align=left colspan=1 style="width:2%;" ><input type="radio" id="idPit" name="option_P" value="10"  onclick="OnClick(10)" ></td>
		            <td align=left colspan=6 style="width:9%;" >Pit</td>
					
					<td align=right colspan=7  >Year</td>
		            <td align=left colspan=7 ><gw:datebox id="idDBYear" type="year" /></td>
		            
		            <td align=right colspan=7 ><gw:icon id="idBtnImp" img="in" text="Import Data" onclick="OnImportNew()" /></td>
		            <td align=center colspan=13  ><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
					
					<td align=left colspan=4></td>
					<td align=right colspan=2></td>
					
					<td colspan=1  align="center"></td>
					<td align=left colspan=1 ></td>
					<td align=left colspan=1 ></td>
		          <!-- -->
					
				</tr>
				                                
	        </table>
			<table id="tblResigned" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdResigned" style="width:100%">
	                    <gw:grid   
				        id="idGridResigned"  
				        header="EmpID|Full Name|Left Date|Resign Type|Resign Code|_Sequence"   
				        format="0|0|0|0|0|0"  
				        aligns="1|1|1|1|1|0"  
				        defaults="||||||"  
				        editcol="0|0|0|0|0|0"  
				        widths="1200|3500|1500|2500|2000|2000"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick = ""/>
	                </td>
	            </tr>
	        </table>
			
	        <table id="tblMaternity" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGridMaternity"  
				        header="EmpID|Full Name|Start DT|End DT|_Sequence"   
				        format="0|0|0|0|0"  
				        aligns="1|1|1|1|1"  
				        defaults="|||||"  
				        editcol="0|0|0|0|0"  
				        widths="2500|3500|2500|2500|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblChild" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td1" style="width:100%">
	                    <gw:grid   
				        id="idGridChild"  
				        header="EmpID|Employee's Name|Employee Child's Name|Birth Date|Start DT|End DT|_Sequence"   
				        format="0|0|0|0|0|0|0"  
				        aligns="1|1|1|1|0|0|0"  
				        defaults="|||||||"  
				        editcol="0|0|0|0|0|0"  
				        widths="1500|3000|3000|2000|2000|2000|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblRelative" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td2" style="width:100%">
	                    <gw:grid   
				        id="idGridRelative"  
				        header="EmpID|Employee's Name|Name of Relative|Birth Date|Relation|Start DT|End DT|Remark|_Sequence"   
				        format="0|0|0|0|0|0|0|0"  
				        aligns="1|1|1|1|1|1|1|1"  
				        defaults="||||||||"  
				        editcol="0|0|0|0|0|0|0|0"  
				        widths="1500|3500|3500|2300|2000|2000|0|0|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>	    		
			
			<table id="tblBankInfo" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td3" style="width:100%">
	                    <gw:grid   
				        id="idGridBankInfo"  
				        header="EmpID|Full Name|Bank Type|Account Number|Pay Type|_Sequence"   
				        format="0|0|0|0|0|0"  
				        aligns="1|1|1|1|1|1"  
				        defaults="||||||"  
				        editcol="0|0|0|0|0|0"  
				        widths="2500|3500|2500|2500|1500|1500|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblAnnualMonth" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td4" style="width:100%">
	                    <gw:grid   
				        id="idGridAnnualMonth"  
				        header="EmpID|Full Name|01|02|03|04|05|06|07|08|09|10|11|12|Year|_Sequence"   
				        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				        aligns="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0"  
				        defaults="||||||||||||||||"  
				        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				        widths="1500|3000|700|700|700|700|700|700|700|700|700|700|700|700|0|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblAnnualDate" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td5" style="width:100%">
	                    <gw:grid   
				        id="idGridAnnualDate"  
				        header="EmpID|Full Name|Absent Date|Absent Hours|_Sequence"   
				        format="0|0|0|0|0"  
				        aligns="1|1|1|1|0"  
				        defaults="|||||"  
				        editcol="0|0|0|0|0"  
				        widths="2500|3500|2500|2500|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			
			<table id="tblInsuranceInfo" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td6" style="width:100%">
	                    <gw:grid   
				        id="idGridInsuranceInfo"  
				        header="EmpID|Full Name|Social No|Social Place|Health No|Health Place|UnEmp Y/N|Union Y/N|Social Date|_Sequence"   
				        format="0|0|0|0|0|0|0|0|0|0"  
				        aligns="1|1|1|1|1|1|1|1|1|0" 
				        defaults="||||||||||"
				        editcol="0|0|0|0|0|0|0|0|0|0"
				        widths="1000|3000|2000|2500|2000|2500|1500|1500|1500|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
			<table id="tblUnion" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td7" style="width:100%">
	                    <gw:grid   
				        id="idGridUnion"
				        header="EmpID|Full Name|Birth Date|Department|Position|Union YN|Note|_imp_seq"
				        format="0|0|0|0|0|0|0|0"
				        aligns="1|1|1|1|1|1|1|1"
				        defaults="|||||||"
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
			<table id="tblPit" style="width:100%;height:90%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="td8" style="width:100%">
	                    <gw:grid   
				        id="idGridPit"
				        header="EmpID|Full Name|Birth Date|Department|Position|Pit|_imp_seq"
				        format="0|0|0|0|0|0|0"
				        aligns="1|1|1|1|1|1|1"
				        defaults="||||||"
				        editcol="0|0|0|0|0|0|0"
				        widths="1000|3000|2000|2500|2000|2500|1500"
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        acceptNullDate
				        oncelldblclick=""
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
		</td>	
		</tr>
</table>
	
</form>
   
</body>

<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtMonth" styles="display:none"/>
<gw:textbox id="txtAleDays" styles="display:none"/>
<gw:textbox id="txtEmpID" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  /> 
<gw:textbox id="txtSequence" text="" styles="display:none"  /> 
<gw:textbox id="txtProcedure" text="" styles="display:none"  /> 
<gw:textbox id="idDBUSR" text="" styles="display:none"  /> 

</html>
