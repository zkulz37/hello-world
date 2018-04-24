<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("prod")%>
<head>
    <title>Component Entry</title>
</head>

<script type="text/javascript" language="javascript">
//------------grdDetail---------
  var gSave = 'select' ;
 //-----------------------------------
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>";
var currentTime = new Date();
var hours, minutes;
function BodyInit()
{
    BindingDataList();
    getHH();
	getMM();
	txtTime.text = hours + ':' + minutes;
	txtEx_RateUSD1.SetReadOnly(true);
	txtEx_RateUSD2.SetReadOnly(true);
	txtEx_RateUSD3.SetReadOnly(true);
	txtEx_RateUSD4.SetReadOnly(true);
	txtEx_RateUSD5.SetReadOnly(true);
	txtEx_RateUSD6.SetReadOnly(true);
	txtEx_Rate1.SetReadOnly(true);
	txtEx_Rate2.SetReadOnly(true);
	txtEx_Rate3.SetReadOnly(true);
	txtEx_Rate4.SetReadOnly(true);
	txtEx_Rate5.SetReadOnly(true);
	txtEx_Rate6.SetReadOnly(true);
	txtTotalAmount.SetReadOnly(true);
	txtFromCashier.SetReadOnly(true);
	txtToCashier.SetReadOnly(true);
}
function OnConfirm()
{
    if(txtAmount1 !="")
    {
        if (confirm("Are you sure you want to close item ?"))
			{
				txtConfirm.text = "Y";
				gSave = "confirm";
				data_jarc0030.Call();		
			}
    }
}
function getHH()
{
	hours = currentTime.getHours() + "";
	if (hours.length < 2)
		hours = "0" + hours;
	else
		hours = hours;
}

function getMM()
{
	minutes = currentTime.getMinutes() + "";
	if (minutes.length < 2)
		minutes = "0" + minutes;
	else
		minutes = minutes;
}
//---------------------------------------------------------
 function BindingDataList()
 {
    var data;
    data ="DATA|USD|USD|VND|VND|EUR|EUR|KRW|KRW"; 
	lstCCY1.SetDataText(data); 
	lstCCY2.SetDataText(data);
	lstCCY3.SetDataText(data); 
	lstCCY4.SetDataText(data);
	lstCCY5.SetDataText(data); 
	lstCCY6.SetDataText(data);
	lstCCY.SetDataText(data);
	data ="DATA|10|GOLF RECEPTION"; 
	lstPoint.SetDataText(data);
	data = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM COMM.TCO_COMPANY WHERE DEL_IF = 0")%>";   
    lstCompany.SetDataText(data);
    GetRateDefault();
    data_jarc0030.StatusInsert();
    txtEmp1_PK.SetDataText("" + user_pk);
 }  
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 function GetRateDefault()
 {
    dso_get_exrate_list.Call();
 }
 function GetRate(pos)
 {
    switch (pos)
    {
        case 'lstCCY1' :
            if(txtAmount1.GetData() != "0" )
            {
               dso_get_exrate_list1.Call(); 
            }
        break;
        case 'lstCCY2' :
            if(txtAmount2.GetData()!="0")
            {
               dso_get_exrate_list2.Call(); 
            }
        break;
        case 'lstCCY3' :
            if(txtAmount3.GetData()!="0")
            {
               dso_get_exrate_list3.Call(); 
            }
        break;
        case 'lstCCY4' :
            if(txtAmount4.GetData()!="0")
            {
               dso_get_exrate_list4.Call(); 
            }
        break;
        case 'lstCCY5' :
            if(txtAmount5.GetData()!="0")
            {
               dso_get_exrate_list5.Call(); 
            }
        break;
        case 'lstCCY6' :
            if(txtAmount6.GetData()!="0")
            {
               dso_get_exrate_list6.Call(); 
            }
        break;
    }
    //dso_get_exrate_list.Call();
 }
function SumAmountUSD()
{
    var TotalUSD=0;
        TotalUSD=Number(txtEx_RateUSD1.GetData())+ Number(txtEx_RateUSD2.GetData()) + Number(txtEx_RateUSD3.GetData())+ Number(txtEx_RateUSD4.GetData()) + Number(txtEx_RateUSD5.GetData())+ Number(txtEx_RateUSD6.GetData());
        txtTotalAmount.SetDataText("" + TotalUSD);
}
function OnDelete()
{
	if(txtMasterPK.text != "")
	{
	    if (confirm('Are you sure delete data ?'))
	    {
		    data_jarc0030.StatusDelete();
		    gSave = 'delete';
		    data_jarc0030.Call();
	    }
	}
}
function OnDataReceive(obj)
{
  switch (obj.id) 
    {
         case "data_jarc0030" :
                if (gSave == 'save' || gSave == 'delete' || gSave == 'confirm' )
                {
                    if(gSave == 'save' || gSave == 'confirm')
                    {
                        gSave = 'stop';
                        data_jarc0030_search.Call("SELECT");
                    }
                    else
                    {
                        gSave = 'stop';
                        data_jarc0030_search.Call("SELECT");
                    }
                }
                else
                {
                    if(txtConfirm.text=="Y")
                    {
                        txtAmount1.SetReadOnly(true);
	                    txtAmount2.SetReadOnly(true);
	                    txtAmount3.SetReadOnly(true);
	                    txtAmount4.SetReadOnly(true);
	                    txtAmount5.SetReadOnly(true);
	                    txtAmount6.SetReadOnly(true);
	                    txtTime.SetReadOnly(true);
                    }
                    else
                    {
                       txtAmount1.SetReadOnly(false);
	                    txtAmount2.SetReadOnly(false);
	                    txtAmount3.SetReadOnly(false);
	                    txtAmount4.SetReadOnly(false);
	                    txtAmount5.SetReadOnly(false);
	                    txtTime.SetReadOnly(false); 
                    }
                }
         break;
         case "dso_get_exrate_list1" :
            var tran_Eur1=0,tran_Vie=0,tran_Krw=0,result_Eur_USD=0,result_Krw_USD=0,result_Vie_USD;
                tran_Eur1=Number(txtTR_RATE1_1.GetData())/Number(txtTR_RATE1.GetData());
                tran_Vie = Number(txtTR_RATE1.GetData());
                tran_Krw = Number(txtTR_RATE1_1.GetData())/Number(txtTR_RATE1.GetData());
                result_Eur_USD=Number(txtAmount1.GetData()) * tran_Eur1;
                result_Krw_USD=Number(txtAmount1.GetData()) * tran_Krw;
                result_Vie_USD=Number(txtAmount1.GetData()) / tran_Vie;
                if(lstCCY1.value=='EUR')
                {
                    txtEx_Rate1.SetDataText("" + tran_Eur1);
                    txtEx_RateUSD1.SetDataText("" + result_Eur_USD);
                }
                if(lstCCY1.value=='VND')
                {
                    txtEx_Rate1.SetDataText("" + tran_Vie);
                    txtEx_RateUSD1.SetDataText("" + result_Vie_USD);
                }
                if(lstCCY1.value=='KRW')
                {
                    txtEx_Rate1.SetDataText("" + tran_Krw);
                    txtEx_RateUSD1.SetDataText("" + result_Krw_USD);
                }
                if(lstCCY1.value=='USD')
                {
                    txtEx_Rate1.text="1";
                    txtEx_RateUSD1.SetDataText("" + txtAmount1.GetData());
                }
                SumAmountUSD();
         break;
         case "dso_get_exrate_list2" :
         
                var tran_Eur1=0,tran_Vie=0,tran_Krw=0,result_Eur_USD=0,result_Krw_USD=0,result_Vie_USD=0;
                tran_Eur1=Number(txtTR_RATE1_2.GetData())/Number(txtTR_RATE1.GetData());
                tran_Vie = Number(txtTR_RATE1.GetData());
                tran_Krw = Number(txtTR_RATE1_2.GetData())/Number(txtTR_RATE1.GetData());
                result_Eur_USD=Number(txtAmount2.GetData()) * tran_Eur1;
                result_Krw_USD=Number(txtAmount2.GetData()) * tran_Krw;
                result_Vie_USD=Number(txtAmount2.GetData()) / tran_Vie;
                if(lstCCY2.value=='EUR')
                {
                    
                    txtEx_Rate2.SetDataText("" + tran_Eur1);
                    txtEx_RateUSD2.SetDataText("" + result_Eur_USD);
                }
                if(lstCCY2.value=='VND')
                {
                    txtEx_Rate2.SetDataText("" + tran_Vie);
                    txtEx_RateUSD2.SetDataText("" + result_Vie_USD);
                }
                if(lstCCY2.value=='KRW')
                {
                    txtEx_Rate2.SetDataText("" + tran_Krw);
                    txtEx_RateUSD2.SetDataText("" + result_Krw_USD);
                }
                if(lstCCY2.value=='USD')
                {
                    txtEx_Rate2.text="1";
                    txtEx_RateUSD2.SetDataText("" + txtAmount1.GetData());
                }
                SumAmountUSD();
         break;
         case "dso_get_exrate_list3" :
                var tran_Eur1=0,tran_Vie=0,tran_Krw=0,result_Eur_USD=0,result_Krw_USD=0,result_Vie_USD;
                tran_Eur1=Number(txtTR_RATE1_3.GetData())/Number(txtTR_RATE1.GetData());
                tran_Vie = Number(txtTR_RATE1.GetData());
                tran_Krw = Number(txtTR_RATE1_3.GetData())/Number(txtTR_RATE1.GetData());
                result_Eur_USD=Number(txtAmount3.GetData()) * tran_Eur1;
                result_Krw_USD=Number(txtAmount3.GetData()) * tran_Krw;
                result_Vie_USD=Number(txtAmount3.GetData()) / tran_Vie;
                if(lstCCY3.value=='EUR')
                {
                    txtEx_Rate3.SetDataText("" + tran_Eur1);
                    txtEx_RateUSD3.SetDataText("" + result_Eur_USD);
                }
                if(lstCCY3.value=='VND')
                {
                    txtEx_Rate3.SetDataText("" + tran_Vie);
                    txtEx_RateUSD3.SetDataText("" + result_Vie_USD);
                }
                if(lstCCY3.value=='KRW')
                {
                    txtEx_Rate3.SetDataText("" + tran_Krw);
                    txtEx_RateUSD3.SetDataText("" + result_Krw_USD);
                }
                if(lstCCY3.value=='USD')
                {
                    txtEx_Rate3.text="1";
                    txtEx_RateUSD3.SetDataText("" + txtAmount1.GetData());
                }
                SumAmountUSD();
         break;
         case "dso_get_exrate_list4" :
                var tran_Eur1=0,tran_Vie=0,tran_Krw=0,result_Eur_USD=0,result_Krw_USD=0,result_Vie_USD;
                tran_Eur1=Number(txtTR_RATE1_4.GetData())/Number(txtTR_RATE1.GetData());
                tran_Vie = Number(txtTR_RATE1.GetData());
                tran_Krw = Number(txtTR_RATE1_4.GetData())/Number(txtTR_RATE1.GetData());
                result_Eur_USD=Number(txtAmount4.GetData()) * tran_Eur1;
                result_Krw_USD=Number(txtAmount4.GetData()) * tran_Krw;
                result_Vie_USD=Number(txtAmount4.GetData()) / tran_Vie;
                if(lstCCY4.value=='EUR')
                {
                    txtEx_Rate4.SetDataText("" + tran_Eur1);
                    txtEx_RateUSD4.SetDataText("" + result_Eur_USD);
                }
                if(lstCCY4.value=='VND')
                {
                    txtEx_Rate4.SetDataText("" + tran_Vie);
                    txtEx_RateUSD4.SetDataText("" + result_Vie_USD);
                }
                if(lstCCY4.value=='KRW')
                {
                    txtEx_Rate4.SetDataText("" + tran_Krw);
                    txtEx_RateUSD4.SetDataText("" + result_Krw_USD);
                }
                if(lstCCY4.value=='USD')
                {
                    txtEx_Rate4.text="1";
                    txtEx_RateUSD4.SetDataText("" + txtAmount1.GetData());
                }
                SumAmountUSD();
         break;
         case "dso_get_exrate_list5" :
                var tran_Eur1=0,tran_Vie=0,tran_Krw=0,result_Eur_USD=0,result_Krw_USD=0,result_Vie_USD;
                tran_Eur1=Number(txtTR_RATE1_5.GetData())/Number(txtTR_RATE1.GetData());
                tran_Vie = Number(txtTR_RATE1.GetData());
                tran_Krw = Number(txtTR_RATE1_5.GetData())/Number(txtTR_RATE1.GetData());
                result_Eur_USD=Number(txtAmount5.GetData()) * tran_Eur1;
                result_Krw_USD=Number(txtAmount5.GetData()) * tran_Krw;
                result_Vie_USD=Number(txtAmount5.GetData()) / tran_Vie;
                if(lstCCY5.value=='EUR')
                {
                    txtEx_Rate5.SetDataText("" + tran_Eur1);
                    txtEx_RateUSD5.SetDataText("" + result_Eur_USD);
                }
                if(lstCCY5.value=='VND')
                {
                    txtEx_Rate5.SetDataText("" + tran_Vie);
                    txtEx_RateUSD5.SetDataText("" + result_Vie_USD);
                }
                if(lstCCY5.value=='KRW')
                {
                    txtEx_Rate5.SetDataText("" + tran_Krw);
                    txtEx_RateUSD5.SetDataText("" + result_Krw_USD);
                }
                if(lstCCY5.value=='USD')
                {
                    txtEx_Rate5.text="1";
                    txtEx_RateUSD5.SetDataText("" + txtAmount1.GetData());
                }
                SumAmountUSD();
         break;
         case "dso_get_exrate_list6" :
                var tran_Eur1=0,tran_Vie=0,tran_Krw=0,result_Eur_USD=0,result_Krw_USD=0,result_Vie_USD;
                tran_Eur1=Number(txtTR_RATE1_6.GetData())/Number(txtTR_RATE1.GetData());
                tran_Vie = Number(txtTR_RATE1.GetData());
                tran_Krw = Number(txtTR_RATE1_6.GetData())/Number(txtTR_RATE1.GetData());
                result_Eur_USD=Number(txtAmount6.GetData()) * tran_Eur1;
                result_Krw_USD=Number(txtAmount6.GetData()) * tran_Krw;
                result_Vie_USD=Number(txtAmount6.GetData()) / tran_Vie;
                if(lstCCY6.value=='EUR')
                {
                    txtEx_Rate6.SetDataText("" + tran_Eur1);
                    txtEx_RateUSD6.SetDataText("" + result_Eur_USD);
                }
                if(lstCCY6.value=='VND')
                {
                    txtEx_Rate6.SetDataText("" + tran_Vie);
                    txtEx_RateUSD6.SetDataText("" + result_Vie_USD);
                }
                if(lstCCY6.value=='KRW')
                {
                    txtEx_Rate6.SetDataText("" + tran_Krw);
                    txtEx_RateUSD6.SetDataText("" + result_Krw_USD);
                }
                if(lstCCY6.value=='USD')
                {
                    txtEx_Rate6.text="1";
                    txtEx_RateUSD6.SetDataText("" + txtAmount1.GetData());
                }
                SumAmountUSD();
         break;
    }
}
function OnSave()
{
    if(txtToCashier.text !="")
    {
        gSave = 'save';
        data_jarc0030.Call();
    }
    else
    {
        alert("Please input Cashier2.");
		return;
    }
}
function OnNew()
{
    data_jarc0030.StatusInsert();
    txtEmp1_PK.SetDataText("" + user_pk);
    txtConfirm.text = "N";
    //alert(txtConfirm.text);
    getHH();
	getMM();
	txtTime.text	= hours + ':' + minutes;
}  
function OnSearch()
{
    data_jarc0030_Search.Call();
}
function GridOnCellClick()
{
    if (grdSearch.row > 0 )
        {
            txtMasterPK.text = grdSearch.GetGridData(grdSearch.row,0);
            data_jarc0030.Call("SELECT");
        }
}
function GetEmployee()
{
    var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtEmp2_PK.text = object[0];
                //txtEmpCode.text = object[1];
                txtToCashier.text = object[2];
             }
}
function CheckTime()
{
    var re = /^\d{1,2}:\d{2}([ap]m)?$/;
    if(txtTime.text != '' && !txtTime.text.match(re)) 
			{
				alert("Invalid time format: " + txtTime.text); 
				txtTime.focus(); 
				return false; 
			}
}
</script>

<body>
    <gw:data id="data_jarc0030_Search" onreceive=""> 
        <xml> 
            <dso id="2" type="grid" function="CRM.sp_sel_jarc0030" >
                <input>
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="chkConfirm" />
                </input>
                <output bind="grdSearch" />    
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------>
    <gw:data id="data_jarc0030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35" function="crm.sp_sel_jarc0030_1" procedure="crm.sp_upd_jarc0030_1">
                <inout>
                    <inout bind="txtMasterPK" /> 
                    <inout bind="lstCompany" /> 
                    <inout bind="dtHandoverDate" />     
                    <inout bind="txtTime" /> 
                    <inout bind="txtEmp1_PK" /> 
                    <inout bind="txtFromCashier" />
                    <inout bind="txtEmp2_PK" />                                        
                    <inout bind="txtToCashier" />  
                    <inout bind="txtAmount1" />
                    <inout bind="lstCCY1" />   
                    <inout bind="txtAmount2" />
                    <inout bind="lstCCY2" /> 
                    <inout bind="txtAmount3" />
                    <inout bind="lstCCY3" /> 
                    <inout bind="txtAmount4" />
                    <inout bind="lstCCY4" /> 
                    <inout bind="txtAmount5" />
                    <inout bind="lstCCY5" />   
                    <inout bind="txtAmount6" />
                    <inout bind="lstCCY6" />                 
                    <inout bind="txtEx_Rate1" />      
                    <inout bind="txtEx_RateUSD1" />  
                    <inout bind="txtEx_Rate2" />
                    <inout bind="txtEx_RateUSD2" />
                    <inout bind="txtEx_Rate3" />
                    <inout bind="txtEx_RateUSD3" />
                    <inout bind="txtEx_Rate4" />                    
                    <inout bind="txtEx_RateUSD4" />                                        
                    <inout bind="txtEx_Rate5" />                    
                    <inout bind="txtEx_RateUSD5" />                     
                    <inout bind="txtEx_Rate6" /> 
                    <inout bind="txtEx_RateUSD6" /> 
                    <inout bind="txtTotalAmount" /> 
                    <inout bind="txtDesc" /> 
                    <inout bind="txtConfirm" /> 
                    <inout bind="lstPoint" /> 
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="lstCCY"/>
                     <input bind="dtHandoverDate"/>  
                </input>
                <output>
                     <output bind="txtTR_RATE1"/>
                     <output bind="txtBK_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="lstCCY1"/>
                     <input bind="dtHandoverDate"/>  
                </input>
                <output>
                     <output bind="txtTR_RATE1_1"/>
                     <output bind="txtBK_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list2" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="lstCCY2"/>
                     <input bind="dtHandoverDate"/>  
                </input>
                <output>
                     <output bind="txtTR_RATE1_2"/>
                     <output bind="txtBK_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list3" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="lstCCY3"/>
                     <input bind="dtHandoverDate"/>  
                </input>
                <output>
                     <output bind="txtTR_RATE1_3"/>
                     <output bind="txtBK_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list4" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="lstCCY4"/>
                     <input bind="dtHandoverDate"/>  
                </input>
                <output>
                     <output bind="txtTR_RATE1_4"/>
                     <output bind="txtBK_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list5" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="lstCCY5"/>
                     <input bind="dtHandoverDate"/>  
                </input>
                <output>
                     <output bind="txtTR_RATE1_5"/>
                     <output bind="txtBK_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list6" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE" > 
                <input> 
                     <input bind="lstCompany"/>
                     <input bind="lstCCY6"/>
                     <input bind="dtHandoverDate"/>  
                </input>
                <output>
                     <output bind="txtTR_RATE1_6"/>
                     <output bind="txtBK_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <table border="1" style="height: 100%; width: 100%">
        <tr style="height: 100%">
            <td id="left" style="width: 25%" valign="top" style="height: 100%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 40%" align="right">
                            <b>Date From</b>
                        </td>
                        <td style="width: 67%">
                             <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                            <!--~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />-->
                        </td>
                        <td style="width: 3%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
                        </td>
                    </tr>
                     <tr style="height: 1%">
                        <td style="width: 37%" align="right"> 
                            <b>Date To</b>
                        </td>
                        <td style="width: 60%" colspan="2">
                            <gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 67%" align="right">
                            <b>Comfirm</b>
                        </td>
                        <td style="width: 30%" colspan="2">
                           <gw:checkbox id="chkConfirm" defaultvalue="Y|N" value="N" onclick='OnSearch()'/>
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                    </tr>
                    <tr style="height: 98%"> 
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Date| Cashier1|Cashier2' format='0|4|0|0' aligns='0|0|0|0' editcol='0|0|0|0'
                                widths='0|1000|2000|1000' sorting='T' autosize="T" styles='width:100%; height:100%' oncellclick="GridOnCellClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 6%;" valign="top">
                        <td colspan="5">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td align="right">Company</td>
                                    <td colspan="3"> <gw:list id="lstCompany" styles='width:100%' onchange="GetRateDefault()" /></td>
                                    <td align="right">Point</td>
                                    <td colspan="3"> <gw:list id="lstPoint" styles='width:100%' onchange="GetRateDefault()" /></td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 13%" align="right">
                                         Date
                                    </td>
                                    <td style="width: 15%">
                                        <gw:datebox id="dtHandoverDate" onchange="GetRateDefault()"  maxlen = "10" text="" styles='width:100%'lang="1" />
                                    </td>
                                    <td style="width: 10%" align="right"><b style="color: Red">*</b>Time 
                                        </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtTime" styles='width:100%;; text-align: center' onchange='CheckTime()' /> 
                                    </td>
                                    <td style="width: 10%" align="right">
                                        
                                    </td>
                                    <td style="width: 15%">
                                    </td>
                                    <td style="width: 7%" align="right"><gw:icon id="idConfirm" img="2" text="Confirm" alt="Confirm Invoice" styles='width:100%'
												    onclick="OnConfirm()" />
                                        </td>
                                    <td style="width: 15%">
                                        <table style="height: 100%; width: 100%">
                                            <tr style="height: 100%;">
                                                <td style="width: 20%">
                                                    <gw:imgbtn id="btnAddNewCop" img="new" alt="New" onclick="OnNew()" />
                                                </td>
                                                <td style="width: 20%">
                                                    <gw:imgbtn id="btnDeleteCop" img="delete" alt="Delete" onclick="OnDelete()" />
                                                </td>
                                                <td style="width: 20%">
                                                    <gw:imgbtn id="btnSaveCop" img="save" alt="Save" onclick="OnSave()" />
                                                </td>
                                                <td style="width: 20%"><gw:imgbtn img="excel" alt="Print Bill" onclick="OnPrint()" /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Cashier1</td>
                                    <td colspan="3"> <gw:textbox id="txtFromCashier" styles='width:100%' /></td>
                                    <td align="right"><a title="Click here to show Employees" onclick="GetEmployee()" href="#tips" /><b style="color: Red">*</b>Cashier2</td>
                                    <td colspan="2"> <gw:textbox id="txtToCashier" styles='width:100%' /></td>
                                    <td align="center">Amount(USD)</td> 
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 10%" align="right">
                                        <b style="color: Red">*</b>Amount1
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtAmount1" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                       CCY</td>
                                    <td style="width: 15%">
                                        <gw:list id="lstCCY1" styles='width:100%' onchange="GetRate('lstCCY1')" />
                                    </td>
                                    <td style="width: 10%" align="right"> 
                                        Ex.Rate
                                    </td>
                                    <td style="width: 15%" colspan=2>
                                        <gw:textbox id="txtEx_Rate1" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtEx_RateUSD1" onenterkey ="SumAmountUSD()" onchange="SumAmountUSD()" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 10%" align="right">
                                        Amount2
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtAmount2" type="number" format="#,###,###,###,###" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        CCY</td>
                                    <td style="width: 15%">
                                        <gw:list id="lstCCY2" styles='width:100%' onchange="GetRate('lstCCY2')" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Ex.Rate
                                    </td>
                                    <td style="width: 15%" colspan=2>
                                        <gw:textbox id="txtEx_Rate2" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtEx_RateUSD2" onenterkey ="SumAmountUSD()" onchange="SumAmountUSD()" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 10%" align="right">
                                        Amount3
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtAmount3" type="number" format="#,###,###,###,###" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        CCY</td>
                                    <td style="width: 15%">
                                        <gw:list id="lstCCY3" styles='width:100%' onchange="GetRate('lstCCY3')" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Ex.Rate
                                    </td>
                                    <td style="width: 15%" colspan=2>
                                        <gw:textbox id="txtEx_Rate3" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtEx_RateUSD3" onenterkey ="SumAmountUSD()" onchange="SumAmountUSD()" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 10%" align="right">
                                        Amount4
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtAmount4" type="number" format="#,###,###,###,###" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        CCY</td>
                                    <td style="width: 15%">
                                        <gw:list id="lstCCY4" styles='width:100%' onchange="GetRate('lstCCY4')" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Ex.Rate
                                    </td>
                                    <td style="width: 15%" colspan=2>
                                        <gw:textbox id="txtEx_Rate4" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtEx_RateUSD4" onenterkey ="SumAmountUSD()" onchange="SumAmountUSD()" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 10%" align="right">
                                        Amount5
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtAmount5" type="number" format="#,###,###,###,###" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        CCY</td>
                                    <td style="width: 15%">
                                        <gw:list id="lstCCY5" styles='width:100%' onchange="GetRate('lstCCY5')" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Ex.Rate
                                    </td>
                                    <td style="width: 15%" colspan=2>
                                        <gw:textbox id="txtEx_Rate5" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtEx_RateUSD5" onenterkey ="SumAmountUSD()" onchange="SumAmountUSD()" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 10%" align="right">
                                        Amount6
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtAmount6" type="number" format="#,###,###,###,###" styles='width:100%' />
                                    </td>
                                    <td style="width: 10%" align="right">
                                        CCY</td>
                                    <td style="width: 15%">
                                        <gw:list id="lstCCY6" styles='width:100%' onchange="GetRate('lstCCY6')" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        Ex.Rate
                                    </td>
                                    <td style="width: 15%" colspan=2>
                                        <gw:textbox id="txtEx_Rate6" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtEx_RateUSD6" onenterkey ="SumAmountUSD()" onchange="SumAmountUSD()" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr style="height: 2%;" valign="top">
                                    <td style="width: 10%" align="right">
                                        
                                    </td>
                                    <td style="width: 15%">
                                    </td>
                                    <td style="width: 10%" align="right">
                                        </td>
                                    <td style="width: 15%">
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                    </td>
                                    <td style="width: 15%" colspan=2>Total Amount(USD)
                                    </td>
                                    <td style="width: 15%">
                                        <gw:textbox id="txtTotalAmount" type="number" format="#,###,###,###,###.##" styles='width:100%' />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Description</td>
                                    <td colspan="7"><gw:textarea id="txtDesc" rows="6" text=""  styles='width:100%;'/></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr <tr style="height: 94%;" valign="top"></tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------------->
<gw:textbox id="txtMasterPK" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtPicturePK" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtEmp1_PK" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtEmp2_PK" maxlen="100" styles='width:100%;display:none' />
<gw:list id="lstCCY" styles="width:100%;display:none" />
<gw:textbox id="txtTR_RATE1" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtTR_RATE1_1" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtTR_RATE1_2" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtTR_RATE1_3" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtTR_RATE1_4" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtTR_RATE1_5" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtTR_RATE1_6" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtBK_RATE1" maxlen="100" styles='width:100%;display:none' /> 
<gw:textbox id="txtConfirm" maxlen="100" styles='width:100%;display:none' /> 
<!------------------------------------------------------------>
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
<!------------------------------------------------------------>
</html>
