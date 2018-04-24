<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Cost Allocate</title>
</head>

<script>
   
    var  user_pk   = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name = "<%=Session("USER_NAME")%>" ;
    var  user_id   = "<%=Session("USER_ID")%>" ;
    
    var  vPage =0;
//-----------------------------------------------------
var G1_Acc_pk           = 1 ;   
    G1_Amount           = 4 ;
    G1_Allocate_Amount  = 5 ;

var G2_No               = 0 ,
    G2_item_code        = 1 ,
    G2_item_name        = 2 ,
    G2_input_qty        = 3 ,
    G2_item_uom         = 4 , 
    G2_mat_amt          = 5 , 
    G2_mat_amt_percent  = 6 , 
    G2_amt_622          = 7 , 
    G2_amt_622_percent  = 8 , 
    G2_amt_627          = 9 , 
    G2_amt_627_percent  = 10 , 
    G2_total            = 11 , 
    G2_Unit_Price       = 12 ;          
    
//--------------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("tabLeft");    
    var right = document.all("tabRight");   
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
        right.style.width="60%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
    
//---------------------------------------------------------

function BodyInit()
{
    GridFormat();
    //-----------------
    BindingDataList() ;
    //-----------------
    //setPage(vPage);
}

//---------------------------------------------------------
 
function GridFormat()
{
	var fg = grdCost.GetGridControl();
	
	if ( grdCost.rows < 2 )
	{
		grdCost.AddRow();
	}
	
	fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true; //Format all col merge : Font = Bold 
	
	fg.FixedRows  = 2;
	fg.MergeCells = 5;
    //-----------------------
	fg.MergeCol(0)     = true;	
	fg.Cell( 0, 0, 0, 1, 0) = "No";
    //-----------------------
	fg.MergeRow(0)     = true;
    //-----------------------
	fg.Cell( 0, 0, 1, 0, 4) = "Product";
		
	fg.Cell( 0, 1, 1, 1, 1) = "Code" ;
	fg.Cell( 0, 1, 2, 1, 2) = "Name" ;
	fg.Cell( 0, 1, 3, 1, 3) = "Qty"  ;
	fg.Cell( 0, 1, 4, 1, 4) = "UOM"  ;
    //-----------------------
	fg.Cell( 0, 0, 5, 0, 6) = "Material" ;
	
	fg.Cell( 0, 1, 5, 1, 5) = "Amount"   ;
	fg.Cell( 0, 1, 6, 1, 6) = "%"        ;
    //-----------------------
	fg.Cell( 0, 0, 7, 0, 8) = "'622'"      ;
	
	fg.Cell( 0, 1, 7, 1, 7) = "Amount"   ;
	fg.Cell( 0, 1, 8, 1, 8) = "%"        ;
    //-----------------------
	fg.Cell( 0, 0, 9, 0,10) = "'627'"      ;
	
	fg.Cell( 0, 1, 9, 1, 9) = "Amount"   ;
	fg.Cell( 0, 1,10, 1,10) = "%"        ;	
    //-----------------------	
	fg.MergeCol(11)     = true;	
	fg.Cell( 0, 0, 11, 1, 11) = "Total Amount";
    //-----------------------
    fg.MergeCol(12)     = true;	
	fg.Cell( 0, 0, 12, 1, 12) = "U/P";
    //-----------------------
    fg.ColWidth(0) = "600" ;//No
	fg.ColWidth(1) = "1500";//Item Code
	fg.ColWidth(2) = "2500";//Item Name
	fg.ColWidth(3) = "1200";//Qty
	fg.ColWidth(4) = "800" ;//UOM
	fg.ColWidth(5) = "0";//Mat Amount
	fg.ColWidth(6) = "0";//%
	fg.ColWidth(7) = "0";//622 Amount
	fg.ColWidth(8) = "0";//%
	fg.ColWidth(9) = "0";//627 Amount
	fg.ColWidth(10)= "0";//%
	fg.ColWidth(11)= "1500";//Total Amount	
	fg.ColWidth(12)= "1200";//U/P
}

//-----------------------------------------------------
 function BindingDataList()
 {
     var data = "";    
       
    data = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";    
    lstCompany.SetDataText(data);
    //-----------------------------------
    var ctrl = grdAccount.GetGridControl();
    
    ctrl.ColFormat(G1_Amount)          = "###,###,###" ; 
    ctrl.ColFormat(G1_Allocate_Amount) = "###,###,###" ;  
    //-----------------------------------
    ctrl = grdCost.GetGridControl();
  
    ctrl.ColFormat(G2_input_qty)       = "###,###,###.##" ;   
    ctrl.ColFormat(G2_mat_amt)         = "###,###,###" ;
    ctrl.ColFormat(G2_mat_amt_percent) = "###,###,###.##" ;
    ctrl.ColFormat(G2_amt_622)         = "###,###,###" ;
    ctrl.ColFormat(G2_amt_622_percent) = "###,###,###.##" ;
    ctrl.ColFormat(G2_amt_627)         = "###,###,###" ;
    ctrl.ColFormat(G2_amt_627_percent) = "###,###,###.##" ;
    ctrl.ColFormat(G2_total)           = "###,###,###" ;
    ctrl.ColFormat(G2_Unit_Price)      = "###,###,###.##" ; 
    //-----------------------------------    
    ctrl.FrozenCols = G2_mat_amt ;
    //-----------------------------------    
}

//-----------------------------------------------------

function OnExcel()
{
     var url = System.RootURL + '/reports/fm/gf/fmgf00100.aspx?company_pk=' + lstCompany.value + '&dtMonth=' + dtMonth.value ;
	 System.OpenTargetPage(url);  
}
//-----------------------------------------------------
 
function OnSearch(pos)
{
    switch (pos)
    {
        case 'pro_fmgf00100_2' :        
            //pro_fmgf00100_2.Call() ;
        break;
        case 'fmgf00100_1' :        
            fmgf00100_1.Call('SELECT') ;
        break;
       case 'fmgf00100':
            fmgf00100.Call('SELECT');
        break ;            
    }
}

//------------------------------------------------

function OnProcess(pos)
{
      switch (pos)         
      {		   
            case 'Allocate' :

//                if ( grdAccount.row <= 0 )
//                {
//                    alert('SELECT ONE ACCOUNT COST TO ALLOCATE !!!');
//                    return;
//                }
 
                //txtAccountPK.text = grdAccount.GetGridData( grdAccount.row, G1_Acc_pk ) ;
                pro_fmgf00100.Call();
    
            break ;      
            case 'CancelAllocate' :
//                if ( grdAccount.row <= 0 )
//                {
//                    alert('SELECT ONE ACCOUNT COST TO CANCEL ALLOCATE !!!');
//                    return;
//                }
                
//                txtAccountPK.text = grdAccount.GetGridData( grdAccount.row, G1_Acc_pk ) ;
                pro_fmgf00100_1.Call();
    
            break ;  
      }      

}
//----------------------------------------------------------------
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case 'pro_fmgf00100':
            alert(txtReturnValue.text);
            OnSearch('fmgf00100_1');
        break ; 
        case 'pro_fmgf00100_1':
            alert(txtReturnValue.text);
            OnSearch('fmgf00100_1');
        break ;         
        case 'pro_fmgf00100_2':
//                vPage = Math.ceil(lblRecord.text / 200) 
//                setPage(vPage)
//                lblRecord.text = lblRecord.text + " record(s)";
//                txtPage.text = 1;
//                page1.innerText = '1';
//                currentPage = 1
//                LoadDataPage(page1,1)
        break ;         
        case 'fmgf00100_1':
            GridFormat();
            //fmgf00100.Call('SELECT') ;
        break ; 
        case 'fmgf00100':
            GridFormat();
            fmgf00100_1.Call('SELECT') ;
        break ; 
    }
}
//--------------------------------------------------------------------
var currentPage = 0;
//----------------------Page divide-----------------------------------
//function LoadDataPage(obj,init)
//{
//   if (obj.style.cursor == 'hand'||init==1)
//   {
//        switch(obj.id)
//        {
//            case 'page1':
//                if (vPage>0)
//                {
//                    ObjectStatus(page1,0)
//                    ObjectStatus(page2,1)
//                    ObjectStatus(page3,1)
//                    currentPage =1
//                }
//            break;
//            case 'page2':
//                ObjectStatus(page1,1)
//                ObjectStatus(page2,0)
//                ObjectStatus(page3,1)
//                currentPage =2
//            break;
//            case 'page3':
//                ObjectStatus(page1,1)
//                ObjectStatus(page2,1)
//                ObjectStatus(page3,0)
//                currentPage =3
//            break;
//        }
//        var page =  obj.innerText
//        txtPage.text = page
//        currentPage = page
//        //------------
//        OnSearch('fmgf00100_1');
//        //------------
//    }
//}
////---------------------------------------------------------------------------------------------------
//function setPage(pPage)
//{
//     
//        ObjectStatus(pagePrev,2)
//        switch(vPage)
//        {
//            case 0:
//                 page1.innerText = 1;
//                 page2.innerText = "";
//                 page3.innerText = "";
//                 ObjectStatus(page1,2)
//                 ObjectStatus(pageNext,2)
//            break;   
//            case 1:
//                 page1.innerText = 1;
//                 page2.innerText = "";
//                 page3.innerText = "";
//                 ObjectStatus(page1,0)   
//                 ObjectStatus(pageNext,2)   
//            break;   
//            case 2:
//                 page1.innerText = 1;
//                 page2.innerText = 2;
//                 page3.innerText = "";
//                 ObjectStatus(pageNext,2)   
//            break;
//            case 3:
//                 page1.innerText = 1;
//                 page2.innerText = 2;
//                 page3.innerText = 3;
//                 ObjectStatus(pageNext,2)   
//            break;
//            default:
//                page1.innerText = 1;
//                page2.innerText = 2;
//                page3.innerText = 3;
//                ObjectStatus(pageNext,1)            
//        }
//}
//function PrevPage()
//{
//     var lastPage =  page3.innerText
//     var firstPage =  page1.innerText
//      if(firstPage > 1 && pagePrev.style.cursor == 'hand')
//      {
//            page1.innerText = parseInt(page1.innerText + "") -1;
//            page2.innerText = parseInt(page2.innerText+ "") -1;
//            page3.innerText = parseInt(page3.innerText+ "") -1;
//            CurrentState(page1)
//            CurrentState(page2)
//            CurrentState(page3)
//            if (page3.innerText < vPage)
//            {
//                ObjectStatus(pageNext,1)
//            }
//             if (page1.innerText == 1)
//            {
//                ObjectStatus(pagePrev,2)
//            }
//        }
//     
//}
//function NextPage()
//{
//  var lastPage =  page3.innerText
//    if(lastPage < vPage && pageNext.style.cursor =='hand')
//        {
//            page1.innerText = parseInt(page1.innerText + "") +1;
//            page2.innerText = parseInt(page2.innerText+ "") +1;
//            page3.innerText = parseInt(page3.innerText+ "") +1;
//            CurrentState(page1)
//            CurrentState(page2)
//            CurrentState(page3)
//            if (page3.innerText==vPage)
//            {
//                ObjectStatus(pageNext,2)
//                }
//             if (page1.innerText != '1')
//            {
//                ObjectStatus(pagePrev,1)
//            }
//        }
//    
//}
//function CurrentState(obj)
//{
//     if(obj.innerText == currentPage)
//    {
//          ObjectStatus(obj,0)
//    }else
//    {
//        ObjectStatus(obj,1)
//    }
//}
//function ObjectStatus(obj,status)
//{
//    if (status==0)
//    {
//        obj.style.cursor ='none';
//        obj.style.color = 'red';
//    }else
//    {
//        if (status==1)
//        {
//            obj.style.cursor ='hand';
//            obj.style.color = 'blue';
//        }else
//        {
//            obj.style.cursor ='none';
//            obj.style.color = 'gray';
//        }
//    }
//}
//----------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------------>
 <%--   <gw:data id="pro_fmgf00100_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="process" procedure="acnt.sp_pro_fmgf00100_2" > 
                <input> 
                     <input bind="lstCompany" /> 
                     <input bind="dtMonth" /> 
                     <input bind="txtProduct" />
                 </input> 
                 <output>
                    <output bind="lblRecord" /> 
                 </output>
            </dso> 
        </xml> 
    </gw:data>--%>
    <!------------------------------------------------------------------------>
    <gw:data id="fmgf00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="acnt.sp_sel_fmgf00100" > 
                <input bind="grdAccount" > 
                     <input bind="lstCompany" /> 
                     <input bind="dtMonth" />                      
                  </input> 
                <output bind="grdAccount" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <gw:data id="fmgf00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="acnt.sp_sel_fmgf00100_1" > 
                <input bind="grdCost" > 
                     <input bind="lstCompany" /> 
                     <input bind="dtMonth" />  
                     <input bind="txtProduct" /> 
                     <input bind="txtPage" />                   
                  </input> 
                <output bind="grdCost" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_fmgf00100" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="ACNT.sp_pro_fmgf00100_3" > 
                <input>
                    <input bind="lstCompany" /> 
                    <input bind="dtMonth" />
                                         
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>    
    <!------------------------------------------------------------------>
    <gw:data id="pro_fmgf00100_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="ACNT.sp_pro_fmgf00100_1" > 
                <input>
                    <input bind="lstCompany" /> 
                    <input bind="dtMonth" />                     
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>        
    <!------------------------------------------------------------------------>
    <table class="table" style="height: 100%; width: 100%" border="1">
        <tr style="height: 2%">
            <td colspan="2">
                <table border="0" style="height: 100%; width: 100%">
                    <tr>
                        <td style="width: 10%" align="right">
                            <b>Company</b>
                        </td>
                        <td style="width: 10%" align="left">
                            <gw:list id="lstCompany" styles="width: 100%" onchange="OnSearch('fmgf00100')" />
                        </td>
                        <td style="width: 10%" align="right">
                            Month</td>
                        <td style="width: 10%" align="left">
                            <gw:datebox id="dtMonth" lang="1" type="month" onchange="OnSearch('fmgf00100')" />
                        </td>
                        <td style="width: 10%" align="right">
                            Product</td>
                        <td style="width: 20%" align="right">
                            <gw:textbox id="txtProduct" csstype="mandatory" styles="width: 100%" onenterkey="OnSearch('pro_fmgf00100_2')" />
                        </td>
                        <td style="width: 20%">
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('fmgf00100')" />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnExcel" img="excel" alt="Report" onclick="OnExcel()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 98%">
            <td id="tabLeft" style="width: 40%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%">
                        <td style="width: 60%">
                        </td>
                        <td style="width: 20%">
                            <gw:icon id="idBtnCancelAllocate" img="in" text="Cancel" styles='width:100%' onclick="OnProcess('CancelAllocate')" />
                        </td>
                        <td style="width: 20%">
                            <gw:icon id="idBtnAllocate" img="in" text="Allocate" styles='width:100%' onclick="OnProcess('Allocate')" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdAccount' header='No|_PK|Acc Code|Acc Name|Amount|Allocate' format='0|0|0|0|0|0'
                                aligns='1|0|0|0|3|3' defaults='|||||' editcol='0|0|0|0|0|0' widths='600|1000|1200|2500|1500|1500'
                                styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="tabRight" style="width: 60%">
                <table style="height: 100%; width: 100%">
<%--                    <tr style="height: 2%">
                        <td style="width: 70%">
                        </td>
                        <td style="width: 15%">
                            <gw:label id="lblRecord" styles="color: blue"></gw:label>
                        </td>
                        <td style="width: 3%" align="right">
                            <b id="pagePrev" style="color: Blue; cursor: hand" onclick="PrevPage()"><u><< </u></b>
                        </td>
                        <td align="center" style="color: gray; cursor: none; width: 3%">
                            <b><u id="page1" style="color: Blue; cursor: hand" onclick="LoadDataPage(this,0)">1
                            </u></b>
                        </td>
                        <td style="width: 3%" align="center">
                            <b><u style="color: Blue; cursor: hand" onclick="LoadDataPage(this,0)" id="page2"></u>
                            </b>
                        </td>
                        <td style="width: 3%" align="center">
                            <b><u id="page3" style="color: Blue; cursor: hand;" onclick="LoadDataPage(this,0)"></u>
                            </b>
                        </td>
                        <td style="width: 3%" align="left">
                            <b id="pageNext" style="color: gray; cursor: none" onclick="NextPage()"><u>>> </u></b>
                        </td>
                    </tr>
--%>                    <tr style="height: 98%">
                        <td colspan="7">
                            <gw:grid id='grdCost' 
							header='NULL|NULL|NULL|NULL|NULL|NULL|NULL|NULL|NULL|NULL|NULL|NULL|NULL'
                            format='0|0|0|0|0|0|0|0|0|0|0|0|0' 
							aligns='1|0|0|3|1|3|3|3|3|3|3|3|3' 
							defaults='||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0' 
							widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                            styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!------------------------------------------------------------------------>
    <gw:textbox id="txtPage" styles="display: none" />
    <!------------------------------------------------------------------------>
    <gw:textbox id="txtAccountPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />
    <!------------------------------------------------------------------------>
</html>
