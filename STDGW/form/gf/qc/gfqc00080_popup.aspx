<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Vina Genuwin</title>
</head>
<%  ESysLib.SetUser("acnt")%>
<script language="javascript">
var flag_select = false;
var row_index;   
row_index = 0;
var _row=0;
var contract_no ="";
function BodyInit()
{   
	        var _contract_no = "<%=Request.querystring("contract_no")%>";
	        var _company_pk = "<%=Request.querystring("company_pk")%>";
	        var _ccy = "<%=Request.querystring("ccy")%>";
	        var   pk = "<%=Request.querystring("PK_ROW")%>";
	        var   _row = "<%=Request.querystring("_row")%>"; 
	        row_index = _row;
	       contract_no = _contract_no; 
	        var ls_current  = "<%=ESysLib.SetListDataFUNC("SELECT acnt.SF_A_GET_DEFAULT('ACBG0040') FROM DUAL")%>";
	         arr  = ls_current.split("|");
            txtCcy_Book.SetDataText(arr[1]);
	        txtContract_No.SetDataText(_contract_no);
	        txtCompany_pk.SetDataText(_company_pk);
	        txtCcy.SetDataText(_ccy);
	         txtseq.SetDataText(pk);
	         CheckKeySeq();
	        //OnFormatGrid();
}
function OnPre()
{
	var callerWindowObj = dialogArguments;
    row_index = parseInt(row_index) - 1;
    //vi nhieu form su dung dialog nay nen minh chia ra theo truong hop
    // truong hop header grid cua form master la 2 dong
    if(callerWindowObj.name == "gfqc00080") 
    {
        //alert(row_index);
	    if (row_index < 2)
	    {	   
		    alert("First record...");
		    row_index = 2;
        }
	    else
	    {
	        var row_pk = callerWindowObj.GetRowPK1(row_index);
	        var row_ContracNo = callerWindowObj.GetRowContractNo(row_index); 
            txtseq.text = row_pk;
           txtContract_No.SetDataText(row_ContracNo);
        
            CheckKeySeq();
	    }/**/
    }
    //alert(row_pk);
    /*else // truong hop header grid cua form master la 1 dong
    {
	    if (row_index < 1){
		    alert("First record...");
		    row_index = 1;
        }
	    else{
	        var row_pk = callerWindowObj.GetRowPK1(row_index);
            txtseq.SetDataText(row_pk);
            CheckKeySeq();
	    }    
    }/**/
}
function OnNext()
{	
    var callerWindowObj = dialogArguments;    
    row_index = parseInt(row_index) +  1;
    var row_pk = callerWindowObj.GetRowPK1(row_index);
    var row_ContracNo = callerWindowObj.GetRowContractNo(row_index);
	if (row_pk < 0){
		alert("Last record...");
		row_index = parseInt(row_index) - 1;
    }
	else {
        txtseq.SetDataText(row_pk);
        txtContract_No.SetDataText(row_ContracNo);
        CheckKeySeq();
	}/**/
	
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OnFormatGrid()
{
             var fg=idGrid.GetGridControl();
             if(txtCcy_Book.text=='USD')
             {
                    
                    fg.ColFormat(6) = "#,###,###,###,###.##";
             }
             else if(txtCcy_Book.text=='VND')
             {
                    fg.ColFormat(6) = "#,###,###,###,###";
             }
             if(txtCcy.text=='USD')
             {
                    fg.ColFormat(5) = "#,###,###,###,###.##";
             }
             else if(txtCcy.text=='VND')
             {
             
                    fg.ColFormat(5) = "#,###,###,###,###";
             }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
            if(obj.id=="dat_Search")
            {
                       
                        OnFormatGrid();
            }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function OnPopup()
{
    var ctrl 	= idGrid.GetGridControl();
	var rows    = ctrl.Rows
	rows = rows - 1;
	var rownum  	= ctrl.Row;
	var colnum  	= ctrl.Col;
	
	if (rownum > 0)		 
	{
//		if (event.col > 1)
//		{
			var pk      = idGrid.GetGridData(ctrl.row, 1);
			var status  = "";
			
		
			var fpath   = System.RootURL + '/form/gf/hg/gfhg00020_popup.aspx?PK_ROW=' + pk + '&ROW=' + ctrl.row + '&ROWS=' + rows + '&APPRCANCEL=' + status;
			var wWidth  = 950;
			var wHeight = 580;
			var x = Math.round((screen.availWidth - wWidth)/2);
			var y = Math.round((screen.availHeight - wHeight)/2);
			
			var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
			   "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
			   "lef="+ x +",top=" + y;
			this.name = "gfqc00080_popup";
			var object = System.OpenModal(fpath, wWidth, wHeight, features,window);
			//  var object = window.open( fpath ,800 , 600 , 'resizable:yes;status:yes');
			// 'resizable:yes;status:yes'
			
//	    }
    }
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GetRowPK(row_index){
    if((row_index < idGrid.rows) && (row_index > 0)){
     
        return idGrid.GetGridData(row_index, 1);
    }
    return -1;
}
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function CheckKeySeq()
{
    
    if (txtseq.text != '')
    {
        
        flag_select = true;
        dat_Search.Call('SELECT');
    }
}
</script>
<body>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dat_Search" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="grid" function="acnt.sp_sel_gfqc00080_1"  > 
            <input  >
                <input bind="txtContract_No"/>
                <input bind="txtCompany_pk"/>
                <input bind="txtseq"/>
            </input>
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data>

<table border="0" style="width: 100%;height:100% " cellpadding="0" cellspacing="0">
	            <tr>
	                            <td width="90%"></td>
	                            <td width="5%" align="right"><gw:imgBtn    img="back" alt="Previous" id="btnBack" 	onclick="OnPre()"/></td>
	                            <td width="5%" align="right"><gw:imgBtn    img="next" alt="Next" id="btnNext" 	onclick="OnNext()" /></td>
	            </tr>
                <tr style="width:100%;height:100%">
                    <td colspan="3">
                        <gw:grid id="idGrid" 
                        header="_No|Seq|Voucher No|Trans.Date|Ccy|Trans.Amt|Book Amt|Description|Local Description"
                            format  ="0|0|0|4|0|0|0|0|0" 
                            aligns  ="0|1|0|1|1|3|3|0|0" 
                            defaults="||||||||" 
                            editcol ="0|0|0|0|0|0|0|0|0"
                            widths="0|1000|1500|1200|500|2000|2000|3000|3000" 
                            styles="width:100%; height:100%"
                            sorting="T"
                           oncelldblclick="OnPopup()"
                            />
                    </td>
                </tr>
            
</table>
<gw:textbox id="txtContract_No" style="width:100%;display:none"  />
<gw:textbox id="txtCompany_pk" style="width:100%;display:none"  />
<gw:textbox id="txtCcy_Book" style="width:100%;display:none"  />
<gw:textbox id="txtCcy" style="width:100%;display:none"  />
<gw:textbox id="txtseq" style="width:100%;display:none"  />

</body>
</html>