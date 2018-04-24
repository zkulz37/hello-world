<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>Item Price Setting</title>
</head>

<script>
    var G1_MASTER_PK    = 0,
        G1_SEQ          = 1,         
        G1_PROCESS_NAME = 2,        
        G1_PARTNER_CHK  = 3,``
        G1_STYLE_CHK    = 4,        
        G1_SPECGRP01_PK = 5,
        G1_SPECGRP02_PK = 6,
        G1_SPECGRP03_PK = 7,
        G1_SPECGRP04_PK = 8,
        G1_SPECGRP05_PK = 9,
        G1_ST_PRICE     = 10,
        G1_USE_YN       = 11,
        G1_DESCRIPTION  = 12;
    //--------------------------------
    var G2_DETAIL_PK    = 0,
        G2_MASTER_PK  	= 1,
        G2_SEQ   		= 2,
		G2_PARTNER_PK   = 3,
        G2_PARTNER_NAME = 4,        
        G2_STITEM_PK    = 5,
        G2_ITEM_NAME    = 6,
		G2_SPEC01_PK	= 7,
		G2_SPEC01_NM 	= 8,
		G2_SPEC02_PK	= 9,
		G2_SPEC02_NM	= 10,
		G2_SPEC03_PK	= 11,
		G2_SPEC03_NM	= 12,
		G2_SPEC04_PK	= 13,
		G2_SPEC04_NM	= 14,
		G2_SPEC05_PK	= 15,
		G2_SPEC05_NM	= 16,
		G2_PROCESS_FEE	= 17,
		G2_USE_YN       = 18,
        G2_DESCRIPTION  = 19;
             
    //====================================================
    function OnToggle(pos) 
	{
        var left = document.all("t-left");
        var right = document.all("t-right");
        var imgArrow1 = document.all("imgArrow1");
        var imgArrow2 = document.all("imgArrow2");

        if (pos == '1') 
		{
            if (imgArrow1.status == "expand" && imgArrow2.status == "expand") 
			{
                left.style.display = "none";
                right.style.display = "";

                imgArrow1.status = "collapse";
                imgArrow2.status = "expand";

                imgArrow1.style.display = "none";
                imgArrow2.style.display = "";
            }
            else if (imgArrow1.status == "expand" && imgArrow2.status == "collapse") 
			{
                left.style.display = "";
                right.style.display = "";

                imgArrow1.status = "expand";
                imgArrow2.status = "expand";

                imgArrow1.style.display = "";
                imgArrow2.style.display = "";
            }
        }
        else 
		{
            if (imgArrow1.status == "expand" && imgArrow2.status == "expand") 
			{
                right.style.display = "";
                right.style.display = "none";

                imgArrow1.status = "expand";
                imgArrow2.status = "collapse";

                imgArrow1.style.display = "";
                imgArrow2.style.display = "none";
            }
            else if (imgArrow1.status == "collapse" && imgArrow2.status == "expand") 
			{
                left.style.display = "";
                right.style.display = "";

                imgArrow1.status = "expand";
                imgArrow2.status = "expand";

                imgArrow1.style.display = "";
                imgArrow2.style.display = "";
            }
        }
    }
    //======================================================
    function BodyInit() 
	{
	    System.Translate(document);
        FormatGrid();
    }
    //=====================================================
    function FormatGrid()
    {
        var data = "<%=ESysLib.SetGridColumnDataSQL(" SELECT   pk, specgrp_nm FROM tlg_it_specgrp WHERE del_if = 0 AND use_yn = 'Y'") %>|#;" ;
        grdMaster.SetComboFormat(G1_SPECGRP01_PK, data);
        grdMaster.SetComboFormat(G1_SPECGRP02_PK, data);
        grdMaster.SetComboFormat(G1_SPECGRP03_PK, data);
        grdMaster.SetComboFormat(G1_SPECGRP04_PK, data);
        grdMaster.SetComboFormat(G1_SPECGRP05_PK, data);
        
    }
    
    //====================================================
    function OnSearch(pos) 
	{
        switch (pos) 
		{
            case 'grdMaster':
                data_dspc00070.Call('SELECT');
            break;
            
			case 'grdDetail':
				if ( grdMaster.row > 0 )
				{
					txtMasterPK.text = grdMaster.GetGridData( grdMaster.row, G1_MASTER_PK);
					 var v_partner_yn, v_style_yn, v_spec_1, v_spec_2, v_spec_3, v_spec_4, v_spec_5
					  //--------------------------
					 v_partner_yn = grdMaster.GetGridData( grdMaster.row, G1_PARTNER_CHK);
					 if(v_partner_yn== -1)
					 {
					     grdDetail.GetGridControl().ColHidden(G2_PARTNER_NAME)          = false ;
					 }else
					 {
					     grdDetail.GetGridControl().ColHidden(G2_PARTNER_NAME)          = true ;
					 } 
					 //--------------------------
					 v_style_yn = grdMaster.GetGridData( grdMaster.row, G1_STYLE_CHK);					
					 if(v_partner_yn == -1)
					 {
					     grdDetail.GetGridControl().ColHidden(G2_ITEM_NAME)          = false ;
					 }else
					 {
					     grdDetail.GetGridControl().ColHidden(G2_ITEM_NAME)          = true ;
					 }
					  //--------------------------
					 v_spec_1 = grdMaster.GetGridData( grdMaster.row, G1_SPECGRP01_PK);
					 if(v_spec_1 =="")
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC01_NM)          = true ;
					 }else
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC01_NM)          = false ;
					 }
					  //--------------------------
					 v_spec_2 = grdMaster.GetGridData( grdMaster.row, G1_SPECGRP02_PK);
					  if(v_spec_2 =="")
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC02_NM)          = true ;
					 }else
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC02_NM)          = false ;
					 }
					  //--------------------------
					 v_spec_3 = grdMaster.GetGridData( grdMaster.row, G1_SPECGRP03_PK);
					  if(v_spec_3 =="")
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC03_NM)          = true ;
					 }else
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC03_NM)          = false ;
					 }
					  //--------------------------
					 v_spec_4 = grdMaster.GetGridData( grdMaster.row, G1_SPECGRP04_PK);
					  if(v_spec_4 =="")
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC04_NM)          = true ;
					 }else
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC04_NM)          = false ;
					 }
					  //--------------------------
					 v_spec_5 = grdMaster.GetGridData( grdMaster.row, G1_SPECGRP05_PK);
					  if(v_spec_5 =="")
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC05_NM)          = true ;
					 }else
					 {
					     grdDetail.GetGridControl().ColHidden(G2_SPEC05_NM)          = false ;
					 }
					
				}
				else
				{
					txtMasterPK.text = '' ;
				}
				
                data_dspc00070_1.Call('SELECT');
            break;                             
        }
    }
    //====================================================
    function OnAddNew(pos) 
	{
        switch (pos) 
		{
            case 'grdMaster':
                grdMaster.AddRow();
                grdMaster.SetGridText(grdMaster.rows - 1, G1_USE_YN, -1             ); 
				grdMaster.SetGridText(grdMaster.rows - 1, G1_SEQ   , grdMaster.rows );                
            break;

            case 'grdDetail':
                if ( grdMaster.row > 0 && grdMaster.GetGridData(grdMaster.row, G1_MASTER_PK) != '') 
				{                    
                    var strPK = grdMaster.GetGridData(grdMaster.row, G1_PARTNER_CHK) + "|" + grdMaster.GetGridData(grdMaster.row, G1_STYLE_CHK) + "|" + grdMaster.GetGridData(grdMaster.row, G1_SPECGRP01_PK) + "|" + grdMaster.GetGridData(grdMaster.row, G1_SPECGRP02_PK) + "|" + grdMaster.GetGridData(grdMaster.row, G1_SPECGRP03_PK) + "|" + grdMaster.GetGridData(grdMaster.row, G1_SPECGRP04_PK) + "|" + grdMaster.GetGridData(grdMaster.row, G1_SPECGRP05_PK);
                    
                    var path = System.RootURL + '/form/ds/pc/dspc00071.aspx?p_pk='+strPK;
                    var object = System.OpenModal( path ,950 , 600 ,  'resizable:yes;status:yes',this);                    
                    if ( object != null ) {
                            var arrTemp;
                            for( var i=0; i < object.length; i++)	  
                            {	    
                                    var arrTemp = object[i];
                                    
                                    grdDetail.AddRow();
                                    grdDetail.SetGridText(grdDetail.rows - 1, G2_SEQ, grdDetail.rows-1);
                                    grdDetail.SetGridText(grdDetail.rows - 1, G2_MASTER_PK, grdMaster.GetGridData(grdMaster.row, G1_MASTER_PK));
																		
                                    grdDetail.SetGridText(grdDetail.rows - 1, G2_PARTNER_PK,   arrTemp[0]);
                                    grdDetail.SetGridText(grdDetail.rows - 1, G2_PARTNER_NAME, arrTemp[1]);
                                    grdDetail.SetGridText(grdDetail.rows - 1, G2_STITEM_PK,    arrTemp[2]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_ITEM_NAME,    arrTemp[3]);
									
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC01_PK, arrTemp[4]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC01_NM, arrTemp[5]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC02_PK, arrTemp[6]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC02_NM, arrTemp[7]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC03_PK, arrTemp[8]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC03_NM, arrTemp[9]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC04_PK, arrTemp[10]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC04_NM, arrTemp[11]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC05_PK, arrTemp[12]);
									grdDetail.SetGridText(grdDetail.rows - 1, G2_SPEC05_NM, arrTemp[13]);
									
									//grdDetail.SetGridText(grdDetail.rows - 1, G2_PROCESS_FEE, arrTemp[14]);
									                     
                                    //grdDetail.SetGridText(grdDetail.rows - 1, G2_USE_YN, -1);                         
                            }	
                     }
                }
				else
				{
					alert("PLS SELECT SAVED PROCESS !");
				}
            break;                                    
        }

    }

    //====================================================
    function OnDataReceive(obj) 
	{
        switch (obj.id) 
		{
			case 'data_dspc00070':
                
            break; 
			
            case 'data_dspc00070_1':
                
            break;    
            case 'pro_dspc00070':
                alert(txtReturnValue.text);
                data_dspc00070_1.Call()
            break;
        }
    }
    //=====================================================
    function OnDelete(pos) 
	{
        switch (pos) 
		{
            case 'grdMaster':
                if (grdMaster.row > 0) 
				{
                    if (grdMaster.GetGridData(grdMaster.row, G1_MASTER_PK) == "") 
					{
                        grdMaster.RemoveRow();
                    }
                    else 
					{
                        if (confirm("Do you want to mark this row to delete?")) 
						{
                            grdMaster.DeleteRow();
                        }
                    }
                }
            break;
            //---------------
            case 'grdDetail':
                if (grdDetail.row > 0) 
				{
                    if (grdDetail.GetGridData(grdDetail.row, G2_DETAIL_PK) == "") 
					{
                        grdDetail.RemoveRow();
                    }
                    else 
					{
                        if (confirm("Do you want to mark this row to delete?")) 
						{
                            grdDetail.DeleteRow();
                        }
                    }
                }
            break;                          
        }
    }
    //===========================================================================================
    function OnUnDelete(pos) 
	{
        switch (pos) 
		{     
            case 'grdMaster':
                    grdMaster.UnDeleteRow();
            break;
            
			case 'grdDetail':
                    grdDetail.UnDeleteRow();
            break;                                                                        
        }
    }
    //===========================================================================================
    function OnSave(pos) 
	{
        switch (pos) 
		{
            case 'grdMaster':
                data_dspc00070.Call();
            break;
            
			case 'grdDetail':
                data_dspc00070_1.Call();
            break;                        
        }
    }
        
   //===========================================================================================
   function OnGenerate()
   {
    if(grdMaster.row >0 )
    {
        if (grdMaster.GetGridData(grdMaster.row, G1_MASTER_PK) == "") 
	    {
	        alert("Please , save this process first!")
	    }else
	    {
            pro_dspc00070.Call();
	    }
    }else
    {
        alert("Please, select one process to generate price!");
    }
				
   }
</script>

<body>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00070" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00070" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" procedure="<%=l_user%>lg_upd_dspc00070"  >
                <input bind="grdMaster" >
                    <input bind="txtProcess" />
                </input> 
                <output bind="grdMaster" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
    <gw:data id="data_dspc00070_1" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="<%=l_user%>lg_sel_dspc00070_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" procedure="<%=l_user%>lg_upd_dspc00070_1"  >
                <input bind="grdDetail" >
                    <input bind="txtMasterPK" />
                    <input bind="txtPartnerItem" />
                    <input bind="txtSpec" />
                </input> 
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>     
    <!---------------------------------------------------------------->
    <gw:data id="pro_dspc00070" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dspc00070" > 
                <input>
                    <input bind="txtMasterPK" />  
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>   
    <!------------------------------------------------------------------>
    
    <table style="width: 100%; height: 100%">
        <tr>
            <td style="width: 40%; height: 100%" id="t-left">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">                        
                         <td align="right" width="5%">
                             <b>Process</b>
                         </td>
                        
                         <td width="90%">
                             <gw:textbox id="txtProcess" styles="width:100%" onenterkey="OnSearch('grdMaster')" />
                         </td>                       
                         <td width="1%" align='right'>
                             <gw:imgbtn id="btnInvSearch" img="search" onclick="OnSearch('grdMaster')" />
                         </td>
                         <td>
                             <gw:icon id="idBtnProcess" img="2" text="Auto Mapping" styles='width:100%' onclick="OnGenerate()" />
                         </td>
                         <td style="width: 1%" align="right">
                             <gw:imgbtn img="new" alt="New" id="btnAdd" onclick="OnAddNew('grdMaster')" />
                         </td>
                         <td style="width: 1%" align="right">
                             <gw:imgbtn img="delete" alt="Delete" id="btnDelete" onclick="OnDelete('grdMaster')" />
                         </td>
                         <td style="width: 1%" align="right">
                             <gw:imgbtn img="udelete" alt="Undelete" id="btnUnDelete" onclick="OnUndelete('grdMaster')" />
                         </td>
                         <td style="width: 1%" align="right">
                             <gw:imgbtn img="save" alt="Save" id="btnUpdate" onclick="OnSave('grdMaster')" />
                         </td> 
                    </tr>
                    <tr style="height: 99%">
                        <td colspan=8>
                            <gw:grid id='grdMaster' header='_pk|Seq|Process Name|Partner|Style|SpecGrp 01|SpecGrp 02|SpecGrp 03|SpecGrp 04|SpecGrp 05|ST Price|Use|Remark'
                                format ='0|0|0|3|3|2|2|2|2|2|1|3|0' 
                                aligns ='0|1|0|1|1|0|0|0|0|0|0|0|0' 
                                editcol='0|1|1|1|1|1|1|1|1|1|1|1|1'
                                widths='0|600|2000|800|800|1200|1200|1200|1200|1200|1200|550|1000' sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('grdDetail')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 2%; white-space: nowrap" align="center">
                <img status="expand" id="imgArrow1" src="../../../system/images/button/previous.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('1')" />
                <img status="expand" id="imgArrow2" src="../../../system/images/button/next.gif"
                    style="cursor: hand; position: center" onclick="OnToggle('2')" />
            </td>
            <td style="width: 58%; height: 100%" id="t-right">                 
               <table name="Process" style="height: 100%; width: 100%">
                    <tr style="height: 1%; width:100%">
                        <td style="width: 5%; white-space:nowrap">
                            Partner/Item
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtPartnerItem" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 5%; white-space:nowrap">
                            Spec
                        </td>
                        <td style="width: 35%">
                            <gw:textbox id="txtSpec" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
                        </td>
						
						<td style="width: 15%">                             
                        </td>
						
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" id="btnSearch1" onclick="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="new" alt="New" id="btnNew1" onclick="OnAddNew('grdDetail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="delete" alt="Delete" id="btnDelete1" onclick="OnDelete('grdDetail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnUnDelete1" img="udelete" alt="UnDelete" onclick="OnUnDelete('grdDetail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="save" alt="Save" id="btnSave1" onclick="OnSave('grdDetail')" />
                        </td>
                    </tr>
                    <tr style="height: 99%; width:100%">
                        <td style="width: 100%" colspan="10">                             
								<gw:grid id='grdDetail'
									header='_PK|_MASTER_PK|Seq|_PARTNER_PK|Partner Name|_STYLE_PK|Style Name|_SPEC01_PK|Spec 01|_SPEC02_PK|Spec 02|_SPEC03_PK|Spec 03|_SPEC04_PK|Spec 04|_SPEC05_PK|Spec 05|Process Fee|Use|Remark'
									format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|3|0'
									aligns='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
									check='|||||||||||||||||||'
									editcol='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1'
									widths='0|0|800|0|2000|0|2000|0|1500|0|1500|0|1500|0|1500|0|1500|1200|800|1000'
									sorting='T' 
									styles='width:100%; height:100%'
									/>                          
                        </td>
                    </tr>
               </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtReturnValue" styles='width:100%;display:none;' />
    <!------------------------------------------->
</body>
</html>
