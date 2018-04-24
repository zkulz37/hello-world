<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Line Plan Entry</title>
</head>
<script>
    
    var G_PLAN_PK   =0,
        G_MONTH     =1,
        G_TAC_ABPLCENTER_PK =2,
        G_PL_NM =3,
        G_ORDER_TYPE_CD  =4,
        G_ITEMGRP_PK  =5,
        G_PLAN_QTY   =6,
        G_PLAN_AMT   =7,
        G_COLLECT_AMT = 8,
        G_MARGIN_QTY  = 9,
        G_PLAN_TYPE = 10;

    //----------------------Body Init --------------------------------------------
     function BodyInit()
     {  
        System.Translate(document);         		      		
		OnChangeTab();
		txtUserPk.text = "<%=Session("USER_PK")%>";   
		
		 var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT  a.CODE, a.CODE_NM FROM tlg_lg_code a ,tlg_lg_code_group b  WHERE a.del_if = 0 and b.DEL_IF =0 AND a.tlg_lg_code_group_pk = b.pk and  b.GROUP_ID ='LGSA1020' ORDER BY a.ord " ) %> ";       
         grdProdPlan.SetComboFormat( G_ORDER_TYPE_CD, data); 
         
         data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT  i.pk , i.GRP_NM FROM tlg_it_itemgrp i where i.del_if =0 and  (i.sale_yn = 'Y' or i.prod_yn ='Y') and i.LEAF_YN = 'Y'  " ) %> ";       
         grdProdPlan.SetComboFormat( G_ITEMGRP_PK, data); 
                  
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
           data_kbsa00060.Call('SELECT');
    }
    
    //----------------------Function Receive --------------------------------------------
    function OnDataReceive(obj)
    {
    
    }
    //----------------------OnReport --------------------------------------------
    function OnReport(obj)
    {
        var url = '';
        switch(obj.id)
        {
            case 'btnExcel1':
                url='/reports/fp/ip/rpt_kbsa00060.aspx?p_factory_pk='+ lstLineGroup.value +'&p_from_date='+ dtDate.value;
                break;
            case 'btnExcel2':
                url='/reports/fp/ip/rpt_kbsa00060_1.aspx?p_factory_pk='+ lstLineGroup.value +'&p_from_date='+ dtDate.value;  
                break;
            default:
                return;
        }
        if(url != '')
        {
            window.open(System.RootURL+url);
        }
    }
    //----------------------OnNew --------------------------------------------
    function OnAddNew()
    {
        if(txtPLPk.text =="")
        {
            alert("Please select PL first!");
            return
        }
        
         grdProdPlan.AddRow();        		               
         grdProdPlan.SetGridText(grdProdPlan.rows-1,G_MONTH, dtMonth.value) ;      
         grdProdPlan.SetGridText(grdProdPlan.rows-1,G_TAC_ABPLCENTER_PK, txtPLPk.text )   ;  
         grdProdPlan.SetGridText(grdProdPlan.rows-1,G_PL_NM,txtPL.text   );      
         grdProdPlan.SetGridText(grdProdPlan.rows-1,G_PLAN_TYPE , radTab.value);
         
       /* if(radTab.value == 1)
        {
             var path = System.RootURL + "/form/kb/sa/kbsa00062.aspx?code_group=LGSA1020";
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if(object !=null)
             {
                 var arrTemp;
		            for(var i = 0 ; i< object.length ; i++)
		            {
		                  arrTemp = object[i];
		                 
		                      grdProdPlan.AddRow();
        		               
		                     grdProdPlan.SetGridText(grdProdPlan.rows-1,G_MONTH, dtMonth.value) ;      
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_TAC_ABPLCENTER_PK, txtPLPk.text )   ;  
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_PL_NM,txtPL.text   );      
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_ORDER_TYPE_CD 	,arrTemp[4] );
                            // grdProdPlan.SetGridText(grdProdPlan.rows-1,G_ITEMGRP_PK  , arrTemp[0]  );
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_ORDER_TYPE ,arrTemp[5]  );    
                            // grdProdPlan.SetGridText(grdProdPlan.rows-1,G_GROUP_NM ,  arrTemp[2] );
		                     grdProdPlan.SetGridText(grdProdPlan.rows-1,G_PLAN_TYPE , radTab.value);
		                
		            }
             }
        }else
        {
             var url = System.RootURL + '/form/kb/sa/kbsa00061.aspx';
		     var obj= System.OpenModal( url, 600, 500, 'resizable:yes;status:yes', this); 
		     if(obj != null )
		     {
		            var arrTemp;
		            for(var i = 0 ; i< obj.length ; i++)
		            {
		                  arrTemp = obj[i];
		                  
		                      grdProdPlan.AddRow();
        		               
		                     grdProdPlan.SetGridText(grdProdPlan.rows-1,G_MONTH, dtMonth.value) ;      
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_TAC_ABPLCENTER_PK, txtPLPk.text )   ;  
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_PL_NM,txtPL.text   );      
                            // grdProdPlan.SetGridText(grdProdPlan.rows-1,G_ORDER_TYPE_CD 	, arrTemp[2]);
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_ITEMGRP_PK  , arrTemp[0]  );
                           //  grdProdPlan.SetGridText(grdProdPlan.rows-1,G_ORDER_TYPE , arrTemp[4] );    
                             grdProdPlan.SetGridText(grdProdPlan.rows-1,G_GROUP_NM ,  arrTemp[2] );
		                     grdProdPlan.SetGridText(grdProdPlan.rows-1,G_PLAN_TYPE , radTab.value);
		               
		            }
		        }		 
        }*/
		 
    }
 //-------------------------------------------------------   
  function OnValid(p_group_pk)
  {
    for (var i =1; i< grdProdPlan.rows ; i ++)
    {
         if(p_group_pk==grdProdPlan.GetGridData(i,G_ITEMGRP_PK))
         {
            if(p_group_pk != "" && p_group_pk == grdProdPlan.GetGridData(i,G_ITEMGRP_PK)) 
            {
                return false;
            }
         }
    }
    return true;
    
  }
     //----------------------OnSave --------------------------------------------
    function OnSave()
    {
        data_kbsa00060.Call();
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
    
    function OnPopup(obj)
{
    if(obj=="PL")
    {
	     var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
        var object  = System.OpenModal(fpath , 700 , 500 , 'resizable:yes;status:yes'); 
        if ( object != null )  
        {
            if (object[0] != 0)
            {
                txtPLPk.text = object[2];     // PK
                txtPL.text =  object[1];     // PL Name
                OnSearch();
            }
        }	
     }else
     {
         var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGSA1020";
         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
     }
}
//-----------------------------------------------------
 function OnChangeTab()
 {
    var strRad = radTab.value;
    switch (strRad)
	{
		case '1':
		    grdProdPlan.GetGridControl().ColHidden(G_ITEMGRP_PK) = true;
		    grdProdPlan.GetGridControl().ColHidden(G_ORDER_TYPE_CD) = false;
		break;
		case '2':
		    grdProdPlan.GetGridControl().ColHidden(G_ITEMGRP_PK) = false;
		    grdProdPlan.GetGridControl().ColHidden(G_ORDER_TYPE_CD) = true;
		break;
    }
    OnSearch();
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
    <gw:data id="data_kbsa00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id = "1" type = "grid" parameter ="0,1,2,3,4,5,6,7,8,9,10" function = "<%=l_user%>lg_sel_kbsa00060" procedure="<%=l_user%>lg_upd_kbsa00060" > 
                <input >
                    <input bind="txtPLPk" />
                    <input bind="dtMonth" />
                    <input bind="radTab" />                   
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
                        <td style="width: 5%; white-space: nowrap" align="center">
                             <b style="color: #1b2ff2; cursor: hand" onclick="OnPopup('PL')"> PL</b>
                        </td>
                        <td style="width: 20%; white-space: nowrap" align="left">
                             <gw:textbox id="txtPL" styles="width:100%" onenterkey="OnSearch()" />
                             <gw:textbox id="txtPLPk" styles="width:100%; display:none" />
                        </td> 
                         <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnReset" img="reset" alt="Clear" onclick="txtPL.text ='';txtPLPk.text=''" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="left">
                            Month
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="left">
                            <gw:datebox id="dtMonth" lang="1" type='month' onchange="OnSearch()" />
                        </td> 
						<td style="width: 25%;"> 
						    <gw:radio id="radTab" value="1" styles="width:100%" onchange="OnChangeTab()"> 
                                            <span value="1" id="radOrder"> <b title="Click to get project" style="color:Blue; cursor:hand" onclick="OnPopup('ORD_TYPE')">Order type</b></span> 
                                            <span value="2" id="radGroup">Item Group</span>                                            
                            </gw:radio>
                       </td>               
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('grdProdPlan')" />
                        </td>
                         <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnNew" img="new" alt="New" onclick="OnAddNew()" />
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
                        <td colspan="17">
                                <gw:grid id='grdProdPlan'
                                header='_PK|_Plan Mon|_TAC_ABPLCENTER_PK|PL Name|Order Type|Group Name|Sale Plan Qty|Sale Plan AMT|Collection AMT|Margin Plan|_PLAN_TYPE'
                                format='0|0|0|0|0|0|1|1|1|1|0'
                                aligns='0|0|0|0|0|0|0|0|0|0|0'
                                check='||||||||||'
                                editcol='0|0|1|1|1|1|1|1|1|1'
                                widths='0|0|0|2000|1500|1500|1500|1500|1500|1500|1500|0'
                                sorting='T'
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
