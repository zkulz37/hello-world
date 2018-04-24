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
		txtUserPk.text = "<%=Session("USER_PK")%>";  
		grdLot.GetGridControl().FrozenCols = 6 ;
		OnFormatGrid();
     } 

 //----------------------Function OnFormatGrid --------------------------------------------
    function OnFormatGrid()
    {   	
		var data="";
	    
		data = "<%=ESysLib.SetListDataSQL("SELECT  i.pk , i.GRP_NM FROM tlg_it_itemgrp i where i.del_if =0  and i.LEAF_YN = 'Y' ")%>||";
		lstGrp.SetDataText(data);
				     		
		var strFormat = "###,###,###,###";
      
    }
    //----------------------Function Search --------------------------------------------
    function OnSearch()
    {    
           data_kbin00010.Call('SELECT');
    }
    
    //----------------------Function Receive --------------------------------------------
    function OnDataReceive(obj)
    {
        lblRecord.text = (grdLot.rows -1)+" record(s)."
    }
    //----------------------OnReport --------------------------------------------
    function OnReport(obj)
    {
        var url = '';
        switch(obj.id)
        {
            case 'btnExcel1':
                url='/reports/fp/ip/rpt_kbin00010.aspx?p_factory_pk='+ lstLineGroup.value +'&p_from_date='+ dtDate.value;
                break;
            case 'btnExcel2':
                url='/reports/fp/ip/rpt_kbin00010_1.aspx?p_factory_pk='+ lstLineGroup.value +'&p_from_date='+ dtDate.value;  
                break;
            default:
                return;
        }
        if(url != '')
        {
            window.open(System.RootURL+url);
        }
    }
   
     //----------------------OnSave --------------------------------------------
    function OnSave()
    {
        data_kbin00010.Call();
    }
  
</script>

<body>
    <gw:data id="data_kbin00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id = "1" type = "grid" parameter ="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26" function = "<%=l_user%>lg_sel_kbin00010" procedure="<%=l_user%>lg_upd_kbin00010" > 
                <input >
                    <input bind="dtFromSearch" />
                    <input bind="dtToSearch" />
                    <input bind="lstGrp" />
                    <input bind="txtItem" />             
                </input> 
                 <output bind="grdLot" />                      
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
                             Item Group
                        </td>
                        <td style="width: 20%; white-space: nowrap" align="left">
                             <gw:list id="lstGrp" styles="width:100%;" />
                        </td>                          
                        <td style="width: 5%; white-space: nowrap" align="left">
                            Item/Lot
                        </td>
                        <td style="width: 15%; white-space: nowrap" align="left">
                            <gw:textbox id="txtItem"  styles="width:69%" />
                        </td> 
                         <td style="width: 5%; white-space: nowrap" align="left">
                            Lot Date
                        </td>                       
                        <td style="width: 15%; white-space: nowrap" align="left">
                            <gw:datebox id="dtFromSearch" lang="1" />
                              ~
                            <gw:datebox id="dtToSearch" lang="1" />
                        </td> 
                        
                        <td style="width: 20%;" align="center">
                          <gw:label id="lblRecord" styles="color: red">row(s)</gw:label>
                        </td>
						           
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('grdProdPlan')" />
                        </td>                             
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 49%">
                        <td colspan="17">
                        <gw:grid id='grdLot'
                            header='_PK|Grp Name|_TLG_IT_ITEM_PK|Item Name|Lot Date|Lot No|Weight(Kg/BL)|HI|Mic|Mat|SCI|Len|Amt|Unf|SFI|Str|Elg|Moist|Rd|+b|Tr Cnt|Tr Area|UQL(w)|SFC(W)|Nep Cnt/g|SCN Cnt/g|DESCRIPTION'
                            format='0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            aligns='0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                            check='||||||||||||||||||||||||||'
                            editcol='0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                            widths='0|1500|0|1500|1200|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                            sorting='T'
                            autosize='T' 
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
