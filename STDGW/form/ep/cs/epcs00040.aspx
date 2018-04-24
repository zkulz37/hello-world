<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head>
    <title>Item Entry</title>
</head>

<script type="text/javascript" src="../../../system/lib/ajax.js"></script>

<script language="javascript" type="text/javascript">
var  
        //-------grdMaster---------  
        G1_PK	        = 0,
        G1_ITEM_CODE	= 1,
        G1_ITEM_NAME	= 2,
        G1_UOM          = 3,
        G1_HS_CODE	    = 4,
        G1_IMEX_TAX	    = 5,
        G1_VAT_TAX      = 6,
        G1_CONS_TAX	    = 7,
        G1_DESCRIPTION	= 8,
        G1_GROUP_PK     = 9,
        //-------grdDetail---------        
        G2_PK	        = 0,
        G2_TIE_ITEM_PK	= 1,
        G2_ST_ITEM_PK	= 2,
        G2_ITEM_PK	    = 3,
        G2_ITEM_CODE	= 4,
        G2_ITEM_NAME    = 5;
    //----------------------------------------    
    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name ="<%=Session("USER_NAME")%>" ;
    var  group = "";
 //---------------------------------------------------------
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
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 } 
//----------------------------------------------------- 
 function OnChangeTab()
 { 
    var strRad = radTab.GetData();
    
    grdMaster.ClearData();
    grdDetail.ClearData();   
          
	switch (strRad)
	{
	    case'':
	        document.all("tabAll").style.color     = "red"; 
	        document.all("tabProduct").style.color     = ""; 
		    document.all("tabItem").style.color = "";
	    break;
		case '1':
		    //document.all("tabProduct").style.display     = "";
		    
		    document.all("tabAll").style.color     = ""; 
	        document.all("tabProduct").style.color     = "red"; 
		    document.all("tabItem").style.color = "";
         break;
        
        case '2':
		    //document.all("tabItem").style.display = "";
 		    
		    document.all("tabAll").style.color     = ""; 
	        document.all("tabProduct").style.color     = ""; 
		    document.all("tabItem").style.color = "red";
         break;	        
     } 
 } 
//-----------------------------------------------------

function BodyInit()
{  
    txtParentNm.SetEnable(false);
    txtGrpCD.SetEnable(false);
    txtGrpNm.SetEnable(false);  
    OnChangeTab();  
    OnSearch('Group');
    BindingDataList();
}
//-----------------------------------------------------
 function BindingDataList()
 {    
    var data="";    
    
    data = "<%=ESysLib.SetGridColumnDataSQL("select  UOM_CODE, UOM_CODE UOM_CODE1 from TLG_IT_UOM where del_if=0  order by UOM_CODE")%>";   
    grdMaster.SetComboFormat(G1_UOM,data);
    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEIM0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY to_number(a.CODE) , a.CODE_NM " ) %> ";       
    grdMaster.SetComboFormat(G1_IMEX_TAX,data);       

    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEIM0040' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY to_number(a.CODE) , a.CODE_NM " ) %> ";       
    grdMaster.SetComboFormat(G1_VAT_TAX,data);       

    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='IEIM0050' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY to_number(a.CODE) , a.CODE_NM " ) %> ";       
    grdMaster.SetComboFormat(G1_CONS_TAX,data);      
  }     
//-----------------------------------------------------
function OnPopUp(obj)
{
    switch(obj)
    {
        case 'STITEM' :
             if(grdMaster.row < 0)
             {
                alert('Pls select one ')
             }
             else
             {
                 var path = System.RootURL + '/form/fp/ab/fpab00350.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];                                
                                grdDetail.AddRow();   

                                grdDetail.SetGridText( grdDetail.rows-1, G2_TIE_ITEM_PK, grdMaster.GetGridData( grdMaster.row, G1_PK));                           
                                grdDetail.SetGridText( grdDetail.rows-1, G2_ST_ITEM_PK, arrTemp[0]);
                                grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_PK, arrTemp[1]);
                                grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE, arrTemp[2]);
                                grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME, arrTemp[3]);
                        }	
                 }   
             }
        break;
        
        
        case 'ITEMMAT' :
            if( oTree.GetCurrentNode() != null)
            {
                 var path = System.RootURL + '/form/ep/cs/epcs00031.aspx?cus_cd=P03L&com_cd=0900283167';//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes;scroll:no');
                 
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];                                
                                grdMaster.AddRow();   
                                //_PK|Item Code|Item Name|UOM|_HS_CODE|Imex Tax|Vat|Cons tax|_DESCRIPTION|_Group
                                // 0    3           4       7   8       11      14      15      

                                grdMaster.SetGridText( grdMaster.rows-1, G1_PK, arrTemp[0]);                     
                                grdMaster.SetGridText( grdMaster.rows-1, G1_ITEM_CODE, arrTemp[3]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_ITEM_NAME, arrTemp[4]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_UOM, arrTemp[7]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_HS_CODE, arrTemp[8]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_IMEX_TAX, arrTemp[11]);                                
                                grdMaster.SetGridText( grdMaster.rows-1, G1_VAT_TAX, arrTemp[14]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_CONS_TAX, arrTemp[15]);                                
                                grdMaster.SetGridText( grdMaster.rows-1, G1_GROUP_PK, oTree.GetCurrentNode().oid);      
                        }	
                 } 
             }
             else
             {
                alert("pls, select one group!");
             }  
        break;
        
        case 'ITEMPROD' :
            if( oTree.GetCurrentNode() != null)
            {
                 var path = System.RootURL + '/form/ep/cs/epcs00051.aspx?cus_cd=P03L&com_cd=0900283167';//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes;scroll:no');
                 
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];                                
                                grdMaster.AddRow();   
                                //_PK|Item Code|Item Name|UOM|_HS_CODE|Imex Tax|Vat|Cons tax|_DESCRIPTION|_Group
                                // 0    3           4       7   8       11      14      15      

                                grdMaster.SetGridText( grdMaster.rows-1, G1_PK, arrTemp[0]);                     
                                grdMaster.SetGridText( grdMaster.rows-1, G1_ITEM_CODE, arrTemp[3]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_ITEM_NAME, arrTemp[4]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_UOM, arrTemp[7]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_HS_CODE, arrTemp[8]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_IMEX_TAX, arrTemp[11]);                                
                                grdMaster.SetGridText( grdMaster.rows-1, G1_VAT_TAX, arrTemp[14]);
                                grdMaster.SetGridText( grdMaster.rows-1, G1_CONS_TAX, arrTemp[15]);                                
                                grdMaster.SetGridText( grdMaster.rows-1, G1_GROUP_PK, oTree.GetCurrentNode().oid);      
                        }	
                 } 
             }
             else
             {
                alert("pls, select one group!");
             }  
        break;
    }           
}
//-----------------------------------------------------

function OnSearch(pos)
{
    switch (pos)
    {
        case 'Group_Type':            
            txtGrpCD.text = "";
            txtGrpNm.text = "";
            txtGrpCD.SetEnable(false);
            txtGrpNm.SetEnable(false);   
            txtPK.SetDataText("");   
            group = radTab.GetData();
            data_epcs00040_3.Call("SELECT");
        break;     
        //----------
        case 'Group':
            txtGrpCD.text = "";
            txtGrpNm.text = "";
            txtGrpCD.SetEnable(false);
            txtGrpNm.SetEnable(false);         
            group = radTab.GetData();
            data_epcs00040_3.Call("SELECT");
        break; 
        //-------------   
        case 'ItemList':           
            grdDetail.ClearData();
            txtPK.SetDataText(oTree.GetCurrentNode().oid);  
            txtParentNm.text = oTree.GetParentNode(oTree.GetCurrentNode()).text;
            data_epcs00040_5.Call("SELECT");                              
        break;           
        //----------    
        case 'Master':
            data_epcs00040.Call('SELECT');
        break;
        //---------
        case 'Detail':
            txtMasterPK.text = grdMaster.GetGridData( grdMaster.row, G1_PK);  
            data_epcs00040_2.Call('SELECT');
        break;        
    }
}

//-----------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_epcs00040':
            lblRecord.text = grdMaster.rows-1 + ' row(s)';
            grdDetail.ClearData();
            lblRecord2.text = grdDetail.rows-1 + ' row(s)';
        break;
        //------------------    
        case 'data_epcs00040_2':
            lblRecord2.text = grdDetail.rows-1 + ' row(s)';
        break;
        //---------------------    
        case 'data_epcs00040_5':
            lblRecord.text = grdMaster.rows-1 + ' row(s)';
            lblRecord2.text = grdDetail.rows-1 + ' row(s)';
        break;
        //------------------    
        case 'data_epcs00040_1':
            data_epcs00040.Call('SELECT');
        break;
       //----------------------             
       case 'data_epcs00040_4':   
            OnChangeTab();     
            radTab.value = group;
            data_epcs00040_3.Call("SELECT");
       break;
       //-------------
       case 'data_epcs00040_3':   
            OnChangeTab();    
            lblRecord.text = grdMaster.rows-1 + ' row(s)';
            lblRecord2.text = grdDetail.rows-1 + ' row(s)';            
       break;       
    }
}
//------------------------------------------------
function OnAddNew(obj)
{ 
    switch(obj)
    {   
       case 'Master':       
               if(txtPK.text != '')
               {
                   grdMaster.AddRow();
                   grdMaster.SetGridText( grdMaster.rows-1, G1_GROUP_PK, oTree.GetCurrentNode().oid);         
               }
               else
               {
                   alert('Pls Select Group first !!!');
               }
       break;
       //---------------
       case 'Group':              
            try
            {
                txtGrpCD.SetEnable(true);
                txtGrpNm.SetEnable(true);
                
                data_epcs00040_4.StatusInsert();
                txtParentPK.SetDataText(oTree.GetCurrentNode().oid); 
                txtParentNm.text = oTree.GetCurrentNode().text;
                txtGrpCD.text = '<< New Code >>' ;
                txtGrpNm.text = '<< New Name >>' ;
                radTab.value = group;
            }
            catch(err)
            {   
                radTab.value = group;
                txtGrpCD.text = '<< New Code >>' ;
                txtGrpNm.text = '<< New Name >>' ;
            }
       break;
       //---------------
       case 'Update_Group': 
           if(txtPK.text != '')
           {
                radTab.value = group; 
                txtGrpCD.SetEnable(true);
                txtGrpNm.SetEnable(true);    
                data_epcs00040_4.Call('SELECT');   
            }
            else
            {
                alert('Pls Select Group first !!!');
            }
       break;       
    }
}
//-----------------------------------------------------

function OnSave(pos)
{
    switch(pos)
    { 
        case 'Group':    
            txtGrpCD.SetEnable(false);
            txtGrpNm.SetEnable(false);        
            data_epcs00040_4.Call();
        break;
        //-----------------------
        case 'Master':
            data_epcs00040_1.Call(); 
        break;
        //-----------------
        case 'Detail':
            data_epcs00040_2.Call(); 
        break;        
    }          
}
//------------------------------------------------------------
function OnDelete(obj)
 {
      switch (obj)         
      {	  
            case 'Master':
                    if ( grdMaster.GetGridData( grdMaster.row, G1_PK ) == '' )
                    {
                        grdMaster.RemoveRow();
                    }
                    else
                    {
                        grdMaster.DeleteRow();
                    }                        
            break;      
            //-------------------
           case 'Detail':
                    if(confirm('Do you want to delete this Item?'))
                    {
                        if ( grdDetail.GetGridData( grdDetail.row, G2_PK ) == '' )
                        {
                            for(var i = 0; i < grdDetail.rows; i++)
                            {
                                grdDetail.RemoveRow(i);
                            }
                        }
                        else
                        {   
                            for(var j = 0; j < grdDetail.rows; j++)
                            {
                                grdDetail.DeleteRow(j);
                            }
                        }    
                    } 
           break;      
           //----------------------
           case 'Group':
                if(txtPK.text != '')
                {
                    if(confirm('Do you want to delete selected group?'))
                    {    
                        data_epcs00040_4.StatusDelete();
                        data_epcs00040_4.Call();
	                }        
	            }
	            else
	            {
	                alert('Pls Select Group first !!!');
	            }
            break;                        
	  }
 }
//---------------------------------------------------------
 function OnUnDelete(obj)  
{
	switch(obj)
	{
	    case 'Master':
	        grdMaster.UnDeleteRow();
	    break;
	    //------------------	
	    case 'Detail':
	        grdDetail.UnDeleteRow();
	    break;	    
	}
}
//------------------------------------------------------------------
function OnProcess(obj)
{
}
//-------------------------
function OnReport()
{
   
}
</script>

<body>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_epcs00040_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" function="lg_sel_epcs00040_2" > 
                <input>
                    <input bind="txtGroupSearch" />
                    <input bind="radTab" />
                </input>
                <output bind="oTree" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_epcs00040_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4" function="lg_sel_epcs00040_3" procedure="lg_upd_epcs00040_2"> 
                <inout> 
                     <inout  bind="txtPK" />
                     <inout  bind="txtParentPK" />                     
                     <inout  bind="txtGrpCD" />
                     <inout  bind="txtGrpNm" />
                     <inout  bind="radTab" />            	                 
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------------->
    <gw:data id="data_epcs00040_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0" function="lg_sel_epcs00040_4"> 
                <input> 
                     <input  bind="txtPK" />
                </input>
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epcs00040" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1" function="lg_sel_epcs00040" > 
                <input>
                    <input bind="txtItem" /> 
                    <input bind="txtPK" />
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epcs00040_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="lg_sel_epcs00040" procedure="lg_upd_epcs00040" >
                <input>                    
                    <input bind="txtMasterPK" /> 
                    <input bind="txtPK" />
                </input> 
                <inout bind="grdMaster" />
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_epcs00040_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="grid" parameter="0,1,2,3" function="lg_sel_epcs00040_1" procedure="lg_upd_epcs00040_1" >
                <input>                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <inout bind="grdDetail" />
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0" border="1">
        <tr>
            <td style="width: 35%" id="left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%; width:100%">
                        <td>
                        </td>
                        <td style="width: 11%" colspan="6">
                            <gw:radio id="radTab" value="" styles="width:100%" onchange="OnChangeTab(),OnSearch('Group_Type')"> 
                                                <span value="" id="tabAll">All</span> 
                                                <span value="1" id="tabProduct">Product</span> 
                                                <span value="2" id="tabItem">Material</span>
                            </gw:radio>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap" align="right" class="style3">
                            Search
                        </td>
                        <td style="width: 96%">
                            <gw:textbox id="txtGroupSearch" styles='width:100%' onenterkey="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnSearchGroup" img="search" alt="Search" text="Search" onclick="OnSearch('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnAddNew" img="new" alt="New" text="New" onclick="OnAddNew('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnUpdate" img="update" alt="Update" text="Update" onclick="OnAddNew('Update_Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Group')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="ibtnSave01" img="save" alt="Save" text="Save" onclick="OnSave('Group')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap" align="right" class="style3">
                            Parent
                        </td>
                        <td style="width: 92%; white-space: nowrap" colspan="6">
                            <gw:textbox id="txtParentPK" styles='width:100%; display:none' />
                            <gw:textbox id="txtParentNm" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="white-space: nowrap" align="right" class="style3">
                            Group
                        </td>
                        <td style="width: 92%; white-space: nowrap" colspan="6">
                            <gw:textbox id="txtGrpCD" styles='width:30%' csstype="mandatory" />
                            <gw:textbox id="txtGrpNm" styles='width:70%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td style="width: 100%;" colspan="7">
                            <gw:tree id="oTree" style="width: 100%; height: 100%; overflow: auto;" onclicknode="OnSearch('ItemList')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 70%" valign="top">
                <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 1%">
                        <td>
                            <table>
                                <tr align="right">
                                    <td>
                                        <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand"
                                            onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap">
                                        Item
                                    </td>
                                    <td style="width: 30%">
                                        <gw:textbox id="txtItem" csstype="mandatory" styles="width:100%" onenterkey="OnSearch('Master')" />
                                    </td>
                                    <td style="text-align: left; width: 5%">
                                        <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('Master')" />
                                    </td>
                                    <td align="center" style="width: 100%">
                                        <gw:label id="lblRecord" styles="color: blue"></gw:label>
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnNew" img="new" alt="Add Item Mat" text="Add" onclick="OnPopUp('ITEMMAT')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnNew" img="new" alt="Add Item Prod" text="Add" onclick="OnPopUp('ITEMPROD')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete('Master')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 30%">
                        <td>
                            <gw:grid id='grdMaster' header='_PK|Item Code|Item Name|UOM|_HS_CODE|Imex Tax|Vat|Cons tax|_DESCRIPTION|_Group'
                                format='0|0|0|2|0|1|1|1|0|0' aligns='0|0|0|1|0|0|0|0|0|0' check='|||||-|-|-||'
                                editcol='1|1|1|1|1|1|1|1|1|1' widths='1000|1200|3000|1200|1200|1200|1200|1200|1200|1000'
                                sorting='T' styles='width:100%; height:100%' oncellclick="OnSearch('Detail')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            <table>
                                <tr>
                                    <td style="width: 100%" align="center">
                                        <gw:label id="lblRecord2" styles="color: blue"></gw:label>
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnNew2" img="new" alt="Add" text="Add" onclick="OnPopUp('STITEM')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnDelete2" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnUnDelete2" img="udelete" alt="UnDelete" text="UnDelete" onclick="OnUnDelete('Detail')" />
                                    </td>
                                    <td>
                                        <gw:imgbtn id="btnSave2" img="save" alt="Save" text="Save" onclick="OnSave('Detail')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 68%">
                        <td>
                            <gw:grid id='grdDetail' header='_PK|_TIE_ITEM_PK|_ST_ITEM_PK|_ITEM_PK|Item Code|Item Name'
                                format='0|0|0|0|0|0' aligns='0|0|0|0|0|0' check='|||||' editcol='1|1|1|1|0|0'
                                widths='1000|1000|1000|1000|2000|3000' sorting='T' styles='width:100%; height:100%' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------------------->
    <!------------------------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtGroupNew_PK" styles='width:100%;display:none' />
    <gw:textbox id="txtPK" styles='width:100%;display:none' />
    <gw:textbox id="txtDetailPK" styles='width:100%;display:none' />
    <gw:textbox id="txtItemMap" styles='width:100%;display:none' />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
    <!------------------------------------------------------------------------------------------->
</body>
</html>
