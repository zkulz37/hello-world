<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	 ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Item Plan Entry</title>
</head>
<script>
    
    var G_PLAN_PK   =0,
        G_MONTH     =1,
        G_ITEM_PK =2,
        G_ITEM_CD =3,
        G_UOM =4,
        G_PROD_PLAM  =5,
        G_REMARK  =6;
        

    //----------------------Body Init --------------------------------------------
     function BodyInit()
     {  
        System.Translate(document);         		      		
		OnChangeTab();
		txtUserPk.text = "<%=Session("USER_PK")%>";   
		          
	   // dso_getCompany.Call();				 
     } 

 //----------------------Function OnFormatGrid --------------------------------------------
    function OnFormatGrid()
    {   	
		var data="";
	    
		data = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 order by 1")%>";
		lstCompany.SetDataText(data);
				     		
		var strFormat = "###,###,###,###";
		var ctrl = grdProdPlan.GetGridControl();
      
    }
    //----------------------Function Search --------------------------------------------
    function OnSearch()
    {    
           data_kbpr00030.Call('SELECT');
    }
    
    //----------------------Function Receive --------------------------------------------
    function OnDataReceive(obj)
    {
        if(grdProdPlan.rows >1)
        {
         grdProdPlan.SetCellBgColor( 1, G_PROD_PLAM,  grdProdPlan.rows - 1, G_PROD_PLAM, 0xCCFFFF ); 
        }
    }
   
    //----------------------OnNew --------------------------------------------
    function OnAddNew()
    {
         var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');         
         if ( object != null )
         {                    
             var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];   
                            grdProdPlan.AddRow();    
                           	grdProdPlan.SetGridText(grdProdPlan.rows-1, G_MONTH, dtMonth.value) ;     	                                               
                            grdProdPlan.SetGridText( grdProdPlan.rows-1, G_ITEM_PK,   arrTemp[0]);//item_pk	  
                             grdProdPlan.SetGridText( grdProdPlan.rows-1, G_ITEM_CD, arrTemp[1]);//item_code	   
                            grdProdPlan.SetGridText( grdProdPlan.rows-1, G_UOM, arrTemp[5]);//item_code	    
                                 
                    }	
          }
     
    }
 //-------------------------------------------------------   
  function OnValid()
  {
    for (var i =1; i< grdProdPlan.rows ; i ++)
    {
        dQuantiy =grdProdPlan.GetGridData(i,G_PROD_PLAM)
        if (Number(dQuantiy))
        {   
            if(dQuantiy <=0)
            {
                alert("Plan Qty must be greater than zero!");
                return false;
            }
        }
         else
         {
               alert("Plan Qty must be greater than zero!");
                return false;
         }
    }
    return true;
    
  }
     //----------------------OnSave --------------------------------------------
    function OnSave()
    {
        if(OnValid())
        {
            data_kbpr00030.Call();
        }
    }
    //----------------------OnDelete --------------------------------------------
    function OnDelete()
    {            
            grdProdPlan.DeleteRow();        
    }
     //----------------------OnUnDelete --------------------------------------------
    function OnUnDelete()
    {            
            grdProdPlan.UnDeleteRow();        
    }
 
//-----------------------------------------------------------
function CheckInput()
{
    var row = grdProdPlan.row;
    var dQuantiy =  grdProdPlan.GetGridData(row,G_PROD_PLAM) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdProdPlan.SetGridText( row, G_PROD_PLAM, System.Round( dQuantiy, 0 ));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdProdPlan.SetGridText( row, G_PROD_PLAM, "");
            }
        }
        else
        {
            grdProdPlan.SetGridText(row,G_PROD_PLAM,"") ;
        } 
 }
</script>

<body>
	 <gw:data id="dso_getCompany" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_kbsa00061" > 
                <input> 
                     <input bind="txtUserPk"/>
                </input>
                <output>
                     <output bind="lstCompany"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbpr00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id = "1" type = "grid" parameter ="0,1,2,3,4,5,6" function = "<%=l_user%>lg_sel_kbpr00030" procedure="<%=l_user%>lg_upd_kbpr00030" > 
                <input >
                     <input bind="dtMonth" />
                 </input> 
                 <output bind="grdProdPlan" />                      
            </dso> 
        </xml> 
    </gw:data>  
    <!------------------------------------------------------------------>
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 50%" id="tab_top">
            <td>
                <table style="height: 100%; width: 100%; text-align: left; vertical-align: top;"
                    border="0">					  
                    <tr style="height: 1%">                     
                        <td style="width: 5%; white-space: nowrap" align="left">
                            Month
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="left">
                            <gw:datebox id="dtMonth" lang="1" type='month' onchange="OnSearch()" />
                        </td> 
						<td style="width: 70%" align='right'>
                            
                        </td>
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnAddNew()" />
                        </td>                 
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('grdProdPlan')" />
                        </td>                             
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete()" />
                        </td>     
                         <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Delete" onclick="OnUnDelete()" />
                        </td>                     
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 49%">
                        <td colspan="8">
                                <gw:grid id='grdProdPlan'
                                header='_PK|_Plan Mon|_Item_PK|Item|UOM|Production Plan|Remark'
                                format='0|0|0|0|0|1|0'
                                aligns='0|0|0|0|0|0|0'
                                check='||||||'
                                editcol='0|0|0|0|0|1|1'
                                widths='0|0|0|1500|800|1500|2000'
                                sorting='T'
                                onafteredit="CheckInput()"
                                styles='width:100%; height:100%'
                                />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>        
    </table>
      <!------------------------------------------------------------------>
    <gw:list id="lstCompany" styles="width:100%"  />
    <gw:textbox id="txtUserPk" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none' />
	
</body>
</html>
