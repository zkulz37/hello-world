<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Allocate Method</title>
</head>
<script>
//-------------------------------------------------------------------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 var  g_company_pk = "<%=Session("COMPANY_PK")%>"  ;
 //------------------------------------------------------------------------
var iMethod_Basic_Account   = '10' ,
    iMethod_User_Defined    = '30' ;

 //Product Group
 var    iG0_tac_pmgroup_pk      = 0,
        iG0_Code                = 1,
        iG0_Group_Name          = 2,
        iG0_PL_CD               = 3,
        iG0_PL_NM               = 4;        
 var 
    iG1_Product_Group           = 0,    
    iG1_from_ac_cd              = 1,
    iG1_from_ac_nm              = 2,
    iG1_TOT_RATIO               = 3,
    iG1_Method                  = 4,
    iG1_Ratio                   = 5,    
    iG1_base_ac_cd              = 6,
    iG1_base_ac_nm              = 7,
    iG1_base_amt_qty            = 8,    
    iG1_to_ac_cd                = 9,
    iG1_to_ac_nm                = 10,    
    iG1_tco_company_pk          = 11,
    iG1_STD_YM                  = 12,
    iG1_tac_pmmethod_pk         = 13,
    iG1_tac_pmgroup_pk          = 14,
    iG1_FROM_ABACCTCODE_PK      = 15,
    iG1_BASE_ABACCTCODE_PK      = 16,
    iG1_TO_ABACCTCODE_PK        = 17;
var iRatio_old = 0 ;    
//------------------------------------------------------------------------
function BodyInit()
{  
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    lstCompany.value = g_company_pk ;
    //Method is format of the list
    
    <%=ESysLib.SetGridColumnComboFormat("grdPMMethod" , 4, " SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='ACFC0010' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ;        
    <%=ESysLib.SetGridColumnComboFormat("grdPMMethod" , 8, " select 'AMOUNT' code, 'AMOUNT' code_nm from dual union select 'QTY' code, 'QTY' code_nm from dual ") %> ;        
    //button status
    btnDelete.SetEnable(false);
    btnUndelete.SetEnable(false);      
    grdPMMethod.AddRow();   
    grdPMMethod.SetRowStatus(grdPMMethod.rows - 1, 0);    
    MergeHeaderGrid();
    
}
//-------------------------------------------------------------------------
function BindingData()
{    
}
function OnShowAll()
{
	if(chkShowAll.value == 'T')
	{
		txtGroup_PK.text = '';
		fmgf00090.Call('SELECT');
	}
}
//-------------------------------------------------------------------------
function MergeHeaderGrid()
{
    

    var fg = grdPMMethod.GetGridControl();                
    fg.FixedRows = 2; 
    fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;
    fg.MergeCells = 5;
    fg.MergeRow(0) = true;   
    //Product Group
    fg.MergeCol(0) = true ;            
    fg.Cell(0, 0, 0, 1, 0) = 'Product Group';   
    // Devided account 
    fg.Cell(0, 0, 1, 0, 2) = 'Devided Account';
    fg.Cell(0, 1, 1, 1, 1) = 'Acc.CD';
    fg.Cell(0, 1, 2, 1, 2) = 'Acc.NM';
    
    //Devided Method
    fg.Cell(0, 0, 3, 0, 8) = 'Devided Method';
    fg.Cell(0, 1, 3, 1, 3) = 'FG(%)';
    fg.Cell(0, 1, 4, 1, 4) = 'Method';
    fg.Cell(0, 1, 5, 1, 5) = 'Ratio(%)';    
    fg.Cell(0, 1, 6, 1, 6) = 'Base Acc.CD';
    fg.Cell(0, 1, 7, 1, 7) = 'Base Acc.NM';
    fg.Cell(0, 1, 8, 1, 8) = 'Amt/Qty';
    //Received Account
    fg.Cell(0, 0, 9, 0, 10)     = 'Received Account';
    fg.Cell(0, 1, 9, 1, 9)      = 'Rcv Acc.CD';
    fg.Cell(0, 1, 10, 1, 10)    = 'Rcv Acc.NM';
}

//-------------------------------------------------------------------------
function OnSearch(iObj)
{
    switch(iObj)
    {
        case 'fmgf00090':
            fmgf00090.Call("SELECT");
        break ;
        case 'fmgf00090_2':
            fmgf00090_2.Call("SELECT");
        break ;        
    }    
}
//-------------------------------------------------------------------------
function OnAddNew()
{
    var lnewrow, j, t;
    
    var ctrl = grdGroup.GetGridControl();
    var path = System.RootURL + "/form/fm/gf/fmgf00092.aspx" ;
    if( grdGroup.row < 1)
    {
        alert("Must select Product Group before adding new");
        return ;
    }
    var object = System.OpenModal( path ,700 , 600 ,  'resizable:yes;status:yes');
    if(object!=null)
    {             
        for (j = 0; j < object.length; j ++)
        {
            var arr = object[j];
            
            for( t = 1; t < grdGroup.rows ; t++)
            {
                if(ctrl.isSelected(t)==true)
                {
                    grdPMMethod.AddRow();
                    lnewrow = grdPMMethod.rows - 1;
                    grdPMMethod.SetGridText(lnewrow, iG1_tco_company_pk, lstCompany.value);
                    grdPMMethod.SetGridText(lnewrow, iG1_STD_YM, dbMonthly.value);
                    grdPMMethod.SetGridText(lnewrow, iG1_tac_pmgroup_pk, grdGroup.GetGridData(t, iG0_tac_pmgroup_pk) );
                    grdPMMethod.SetGridText(lnewrow, iG1_Product_Group, grdGroup.GetGridData(t, iG0_Group_Name) );
                    grdPMMethod.SetGridText(lnewrow, iG1_FROM_ABACCTCODE_PK, arr[3] );
                    grdPMMethod.SetGridText(lnewrow, iG1_from_ac_cd, arr[0] );
                    grdPMMethod.SetGridText(lnewrow, iG1_from_ac_nm, arr[1] );
                    grdPMMethod.SetGridText(lnewrow, iG1_Ratio, '100' );
                    
                }                
            }//for t
        } // for j
    }// object <> null
}
//-------------------------------------------------------------------------
function OnDoubleClick()
{
    var lrow = event.row ;
    var lcol = event.col;
    if(lcol == iG1_Product_Group)
    {
        var path = System.RootURL + "/form/fm/gf/fmgf00091.aspx";
        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
        if(object!=null)
        {
            grdPMMethod.SetGridText(lrow, iG1_tac_pmgroup_pk, object[0] );            
            grdPMMethod.SetGridText(lrow, iG1_Product_Group, object[2] );            
        }        
    }
    else if(lcol == iG1_from_ac_cd )
    {
        if(Trim(lstCompany.value)=='')
        {
            alert('Must select Company!!!');
            return ;
        }            
        var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00090_1&val1=" + lstCompany.value + "&val2=&val3=" ;
        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
        if(object!=null)
        {
            grdPMMethod.SetGridText(lrow, iG1_FROM_ABACCTCODE_PK,object[3] );
            grdPMMethod.SetGridText(lrow, iG1_from_ac_cd,object[0] );
            grdPMMethod.SetGridText(lrow, iG1_from_ac_nm,object[1] );
        }
    } 
    else if(lcol == iG1_base_ac_cd)
    {
        if(Trim(lstCompany.value)=='')
        {
            alert('Must select Company!!!');
            return ;
        }            
        var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00090_1&val1=" + lstCompany.value + "&val2=&val3=" ;

        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
        if(object!=null)
        {
            grdPMMethod.SetGridText(lrow, iG1_BASE_ABACCTCODE_PK,object[3] );
            grdPMMethod.SetGridText(lrow, iG1_base_ac_cd, object[0] );
            grdPMMethod.SetGridText(lrow, iG1_base_ac_nm, object[1] );
        }
    }
    else if(lcol == iG1_to_ac_cd )
    {
        if(Trim(lstCompany.value)=='')
        {
            alert('Must select Company!!!');
            return ;
        }            
        var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00090_1&val1=" + lstCompany.value + "&val2=&val3=" ;

        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
        if(object!=null)
        {
            grdPMMethod.SetGridText(lrow, iG1_TO_ABACCTCODE_PK,object[3] );
            grdPMMethod.SetGridText(lrow, iG1_to_ac_cd, object[0] );
            grdPMMethod.SetGridText(lrow, iG1_to_ac_nm, object[1] );
        }
    }
}
//-------------------------------------------------------------------------
function OnDelete()
{
    var i, lRatio = 0;
    grdPMMethod.DeleteRow();    
    btnDelete.SetEnable(false);
    btnUndelete.SetEnable(true);        
}
//-------------------------------------------------------------------------
function OnUndoDelete()
{
    var i, lRatio = 0;
    grdPMMethod.UnDeleteRow();    
    btnDelete.SetEnable(true);
    btnUndelete.SetEnable(false);        
}
//-------------------------------------------------------------------------
function OnSave()
{
    if(CheckSave())
        fmgf00090.Call();    
}
//-------------------------------------------------------------------------
function CheckSave()
{
    var i, lRatio ;    
    var lMethod ='', l_from_ac_cd = '' ;
    lRatio = 0;
    for(i = 2; i < grdPMMethod.rows ; i++)
    {
        // validate required fields
        if( Trim(grdPMMethod.GetGridData(i, iG1_tac_pmgroup_pk)) == '' ) 
        {
            alert('Please choose Product Group for row ' + i);
            return false;
        }
        else if(Trim(grdPMMethod.GetGridData(i, iG1_FROM_ABACCTCODE_PK)) == '' ) 
        {
            alert('Please select Received Account Code for row ' + i);
            return false;
        }
        
        l_from_ac_cd = Trim(grdPMMethod.GetGridData(i, iG1_from_ac_cd)) ;        
        
        if(l_from_ac_cd != '154000' )
        {
            if(Trim(grdPMMethod.GetGridData(i, iG1_Ratio)) == '' ) //
            {
                alert('Please enter ratio for row ' + i);
                return false;
            }
            else if(Trim(grdPMMethod.GetGridData(i, iG1_Method)) == '' )
            {
                alert('Please select calculation costing method for row ' + i);
                return false;
            }
            else
            {
                lMethod = grdPMMethod.GetGridData(i, iG1_Method) ;            
                if(Trim(lMethod) == iMethod_User_Defined )  //USER DEFINED method 
                {
                    if(Trim(grdPMMethod.GetGridData(i, iG1_TOT_RATIO)) == '')
                    {
                        alert('Please enter cost(%) for row ' + i);
                        return false;
                    }
                }
                else if(Trim(lMethod) == iMethod_Basic_Account ) //BASIC ACCOUNT 
                {
                    if(Trim(grdPMMethod.GetGridData(i, iG1_BASE_ABACCTCODE_PK)) == '')
                    {
                        alert('Please select Base Account Code for row ' + i);
                        return false;
                    }
                    else if(Trim(grdPMMethod.GetGridData(i, iG1_base_amt_qty)) == '')
                    {
                        alert('Please select Amount/Qty for row ' + i);
                        return false;                
                    }
                }
            }
        }            
        else
        {
            if(Trim(grdPMMethod.GetGridData(i, iG1_TOT_RATIO)) == '' )
            {
                alert('Please enter percentage cost for row ' + i);
                return false;
            }        
        }
    }
    return true ;
}
//-------------------------------------------------------------------------
function OnChange()
{
    var lcol = event.col ;
    var lrow = event.row ;
    //
    if( lcol == iG1_Ratio )
    {
        if( Trim(grdPMMethod.GetGridData(lrow, lcol)) != '' && isNaN(grdPMMethod.GetGridData(lrow, lcol)) )
        {
            alert('Enter a valid number for Ratio!'); 
            grdPMMethod.SetGridText(lrow, lcol, '0');
            return false;
        }
    }    
    return true;
}
//-------------------------------------------------------------------------
function OnDataReceive(iObj)
{
    var i, lRatio = 0 ;
    switch(iObj.id)
    {
        case 'fmgf00090_2':
            fmgf00090.Call('SELECT');            
        break;
        case 'fmgf00090':                    
            MergeHeaderGrid();                             
            if(grdPMMethod.rows > 1)
            {
                btnDelete.SetEnable(true);
                btnUndelete.SetEnable(false);        
            }
            else
            {
                btnDelete.SetEnable(false);
                btnUndelete.SetEnable(false);        
            } 

        break;
    }
}
//-------------------------------------------------------------------------
function OnBeforeChange()
{
    var lRatio ;
    var lrow, lcol ;
    lrow = event.row ;
    lcol = event.col;
    if(lcol == iG1_Ratio && Trim(grdPMMethod.GetGridData(lrow, lcol)) != '' )
    {
        iRatio_old = grdPMMethod.GetGridData(lrow, lcol);
    }
    else
    {
        iRatio_old = '0';
    }
}
//-------------------------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("tLEFT");    
    var right = document.all("tRIGHT");   
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
//----------------------------------------------------------------------------
function OnShowGroup()
{
    txtGroup_PK.text = grdGroup.GetGridData(grdGroup.row, iG0_tac_pmgroup_pk );    
    if(chkShowAll.value == "T")
    {
        txtGroup_PK.text = "";
    }
    OnSearch("fmgf00090");
}
//----------------------------------------------------------------------------
</script>
<body>
<!-------------------------------------------------------------------------->
    <gw:data id="fmgf00090" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"  function="ACNT.sp_sel_fmgf00090" procedure="acnt.sp_upd_fmgf00090" > 
                <input bind="grdPMMethod" >  
                    <input bind="lstCompany"/>
                    <input bind="dbMonthly"/>
                    <input bind="txtGroup_PK"/>
                </input>
                <output  bind="grdPMMethod" />
            </dso> 
        </xml> 
    </gw:data>
<!-------------------------------------------------------------------------->
    <gw:data id="fmgf00090_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="ACNT.sp_sel_fmgf00090_2" > 
                <input bind="grdGroup" >  
                    <input bind="lstCompany"/>
                    <input bind="txtGroup_CD"/>
                </input>
                <output  bind="grdGroup" />
            </dso> 
        </xml> 
    </gw:data>
<!-------------------------------------------------------------------------->
    <table style="width:100%; height: 100%; " border="1" >
        <tr style="height: 5%;">
            <td colspan="1" >
                <table style="width:100%; ">
                    <td style="width: 10%; " align="right" >Company</td>
                    <td style="width: 20%; " align="left" ><gw:list id="lstCompany" styles="width:100%; " onchange="OnSearch('fmgf00090_2')" /></td>
                    <td style="width: 10%; " align="right" >Monthly</td>
                    <td style="width: 15%; " align="left" ><gw:datebox id="dbMonthly" type="month" lang="1" onchange="OnSearch('fmgf00090_2')" /></td>                    
                    <td style="width: 8%; " align="right" >All Group</td>
                    <td style="width: 2%;" align="left" ><gw:checkbox id="chkShowAll" styles="width:100%; " value="F" onclick="OnShowAll()" /></td>
                    <td style="width: 3%; " align="right" ><font color="red" ><gw:label id="lblRatio" text="" styles="width:100%; " /></font></td>
                    <td style="width:1%; "><font color="red" ><b></b></font></td>
                    <td style="width: 14%;" align="right"><gw:imgbtn id="btnSearch" text="Search" img="search" alt="Search" onclick="OnSearch('fmgf00090_2')" /></td>
                    <td style="width: 3%;" align="right"><gw:imgbtn id="btnNew" text="New" img="new" alt="New" onclick="OnAddNew()" /></td>
                    <td style="width: 3%;" align="right"><gw:imgbtn id="btnDelete" text="Delete" img="delete" alt="Delete" onclick="OnDelete()" /></td>
                    <td style="width: 3%;" align="right"><gw:imgbtn id="btnUndelete" text="Undelete" img="udelete" alt="Undelete" onclick="OnUndoDelete()" /></td>                    
                    <td style="width: 3%;" align="right"><gw:imgbtn id="btnSave" text="Save" img="save" alt="Save" onclick="OnSave()" /></td>
                    <td style="width: 5%; " align="center"></td>                    
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table style="height:95%; width:100%; " border="1" >
                    <tr>
                        <td id="tLEFT" style="width: 25%; " >
                            <gw:grid id="grdGroup" 
                                header="_tac_pmgroup_pk|Code|Group Name|PL.CD|PL.NM"
                                format="0|0|0" aligns="0|0|0" defaults="||" editcol="0|1|1"
                                widths="0|1000|2000" styles="width:100%; height:100% " sorting="T"
                                parameter="0,1,2"                                
                                acceptNullDate="T"
                                oncellclick="OnShowGroup()" />                        
                        <td id="tRIGHT" style="width: 75%; " >
                            <gw:grid id="grdPMMethod" 
                                header="Product Group|Acc.CD|Acc.NM|FG(%)|Method|Ratio(%)|Base Acc.CD|Base Acc.NM|Amt/Qty|Received Acc.CD|Receipt Acc.NM|_tco_company_pk|_STD_YM|_tac_pmmethod_pk|_tac_pmgroup_pk|_FROM_ABACCTCODE_PK|_BASE_ABACCTCODE_PK|_TO_ABACCTCODE_PK"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                aligns="0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0|0" 
                                defaults="|||||||||||||||||" 
                                editcol="1|1|1|1|1|1|1|1|1|0|1|1|1|0|1|1|0|0"
                                widths="2000|1500|2000|1000|1500|1000|1500|2000|1000|1500|2000|0|0|0|0|0|0|0" 
                                styles="width:100%; height:100% " 
                                sorting="T"
                                parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" 
                                oncelldblclick="OnDoubleClick()" 
                                onafteredit="OnChange()"
                                onbeforeedit="OnBeforeChange()"                                                                                         
                                acceptNullDate="T" />                        
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
<!-------------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />    
<!-------------------------------------------------------------------------->
<gw:textbox id="txtGroup_PK" styles="display:none; " />
<gw:textbox id="txtGroup_CD" styles="display:none; " />
</body>

</html>