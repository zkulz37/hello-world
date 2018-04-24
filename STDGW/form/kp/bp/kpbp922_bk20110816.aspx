<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
</head>
<%  ESysLib.SetUser("EC111")%>


<script>
var flag = '';

var EQ_PK							= 0,
	EQ_LEVEL_PK						= 1,
	EQ_LEVEL						= 2,
	EQ_ITEM_NO						= 3,
	EQ_NAME							= 4,
	EQ_STANDARD						= 5,
	EQ_WEIGHT						= 6,
	EQ_UOM							= 7,
	EQ_CCY							= 8
	EQ_QTY							= 9,
	EQ_UNIT_COST					= 10,
	EQ_AMT							= 11,
	EQ_ORDER_PK						= 12,
	EQ_ORDER_CODE					= 13,
	EQ_ORDER_NAME					= 14,
	EQ_EX_YN						= 15,
	EQ_BUDGET_PK					= 16,
	EQ_BUDGET_CODE					= 17,
	EQ_STANDARD_PBS					= 18,
	EQ_DEVL_TERM					= 19,
	EQ_ORDER_STATUS					= 20,
	EQ_RSLT_YN						= 21,
	EQ_PROJECT_PK					= 22,
	EQ_TECPS_UNDERTAKECTRTBASC_PK	= 23,
	EQ_UNDERTAKESEQ					= 24,
	EQ_TECPS_PERFORMBUDGETBASC_PK	= 25,
	EQ_BOOKING_AMT					= 26,
	EQ_SEQ_NO						= 27,
	EQ_NUM							= 28;

var CONS_PK							= 0,
	CONS_TAKE_LEVEL					= 1,
	CONS_LEVEL						= 2,
	CONS_CODE						= 3,
	CONS_NAME						= 4,
	CONS_STAN						= 5,
	CONS_UNIT						= 6,
	CONS_CCY						= 7,
	CONS_QTY						= 8,
	CONS_UNIT_PRICE					= 9,
	CONS_RAW						= 10,
	CONS_LABOR						= 11,
	CONS_EXP_UP						= 12,
	CONS_LABOR_UNIT_PRICE			= 13,
	CONS_AMT						= 14,
	CONS_ORDER_PK					= 15,
	CONS_ORDER_CODE					= 16,
	CONS_ORDER_NAME					= 17,
	CONS_EXEC_YN					= 18,
	CONS_DIR_MGT					= 19,
	CONS_BUDGET_PK					= 20,
	CONS_BUDGET_CODE				= 21,
	CONS_STAN_CODE					= 22,
	CONS_CALC_BASIC					= 23,
	CONS_ORDER_STA					= 24,
	CONS_RSLT_YN					= 25,
	CONS_PROJECT_PK					= 26,
	CONS_TECPS_UNDERTAKECTRTBASC_PK	= 27,
	CONS_UNDERTAKESEQ				= 28,
	CONS_TECPS_PERFORMBUDGETBASC_PK	= 29,
	CONS_BOOKING_AMT				= 30,
	CONS_SEQ_NO						= 31,
	CONS_NUM						= 32;

var CM_PK								= 0,
	CM_NO								= 1,
	CM_DES								= 2,
	CM_LEVEL_PK							= 3,
	CM_NAME								= 4,
	CM_UOM								= 5,
	CM_QTY								= 6,
	CM_DIRECT_CCY						= 7,
	CM_DIRECT_MM						= 8,
	CM_DIRECT_UNIT_COST					= 9,
	CM_DIRECT_AMT						= 10,
	CM_OUTSRC_CCY						= 11,
	CM_OUTSRC_MM						= 12,
	CM_OUTSRC_UNIT_COST					= 13,
	CM_OUTSRC_AMT						= 14,
	CM_SUM								= 15,
	CM_OUTSITE_PK						= 16,
	CM_OUTSITE_CODE						= 17,
	CM_OUTSITE_NAME						= 18,
	CM_ORDER_STATUS						= 19,
	CM_RSLT_YN							= 20,
	CM_PROJECT_PK						= 21,
	CM_TECPS_UNDERTAKECTRTBASC_PK		= 22,
	CM_UNDERTAKESEQ						= 23,
	CM_TECPS_PERFORMBUDGETBASC_PK		= 24,
	CM_BOOKING_AMT						= 25,
	CM_SEQ_NO							= 26,
	CM_NUM								= 27;

var OTHER_PK							= 0,
	OTHER_LEVEL_PK						= 1,
	OTHER_LEVEL							= 2,
	OTHER_SRVC_FLD						= 3,
	OTHER_NAME							= 4,
	OTHER_STANDARD						= 5,
	OTHER_UNIT							= 6,
	OTHER_CCY							= 7,
	OTHER_QTY							= 8,
	OTHER_UNIT_PRICE					= 9,
	OTHER_AMT							= 10,
	OTHER_ORDER_PK						= 11,
	OTHER_ORDER_CODE					= 12,
	OTHER_ORDER_NAME					= 13,
	OTHER_ORDER_STATUS					= 14,
	OTHER_RSLT_YN						= 15,
	OTHER_PROJECT_PK					= 16,
	OTHER_TECPS_UNDERTAKECTRTBASC_PK	= 17,
	OTHER_UNDERTAKESEQ					= 18,
	OTHER_TECPS_PERFORMBUDGETBASC_PK	= 19,
	OTHER_BOOKING_AMT					= 20,
	OTHER_SEQ_NO						= 21,
	OTHER_NUM							= 22;
 //===========================================================================================================================
function BodyInit()
{
      System.Translate(document);
	  var vendor1 = document.all("info_1"); 
				var vendor2 = document.all("info_2"); 
				var vendor3 = document.all("info_3"); 
				var vendor4= document.all("info_4"); 
				vendor1.style.display = "none";
				vendor2.style.display = "none";
				vendor3.style.display = "none";
				vendor4.style.display = "";
				imgup.src = "../../../system/images/up.gif";
                idTab.SetPage(1);
      BindingDataList();
	  Merge_grid(grdEQ);
	 Merge_grid(grdCONS);
	 Merge_grid(grdCM);
	 Merge_grid(grdOther);
	 Merge_grid(Grid_Design);
	 
     grdEQ.GetGridControl().WordWrap = true;
     grdCONS.GetGridControl().WordWrap = true;
     grdCM.GetGridControl().WordWrap = true;
     grdOther.GetGridControl().WordWrap = true;
	 Grid_Design.GetGridControl().WordWrap = true;
	 Hide();
	
}    
//===========================================================================================================================
function BindingDataList()
{
//		var ls_Work_Breakdown = "<%=ESysLib.SetListDataSQL("select pk, undertakelevelname from ec111.tecps_undertakelevelcode where del_if = 0 order by undertakelevelname")%>|ALL|Select All";
//    lstWork_Breakdown.SetDataText(ls_Work_Breakdown); 
//    lstWork_Breakdown.value = 'ALL'; 
	data = "DATA|ALL|Select All|1|Working Item No.|2|Name|3|Standard|4|Budget Code|5|Standard PBS";
	lstFilter1.SetDataText(data);
	lstFilter1.value = 'ALL';
    data = "DATA|ALL|Select All|1|Level|2|Name|3|Standard|4|Order W. Code|5|Budget Code|6|Standard Code";
	lstFilter2.SetDataText(data);
	lstFilter2.value = 'ALL';
    data = "DATA|ALL|Select All|1|Level|2|Name|3|Standard|4|Order W. Code";
	lstFilter4.SetDataText(data);
	lstFilter4.value = 'ALL';
    data = "DATA|A|AND|O|OR";
    lstUP.SetDataText(data);
    data = "DATA|A|AND|O|OR";
    lstPriceRange.SetDataText(data);
	// Equiment
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 15,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 7 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 21,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdEQ", 8,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 
	// Contruction
	//Exec.YN
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 17,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 5 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 24,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	 <%=ESysLib.SetGridColumnComboFormat("grdCONS", 6,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>|#;";

	grdCM.SetComboFormat(7, data);
	grdCM.SetComboFormat(11, data);

	<%=ESysLib.SetGridColumnComboFormat("grdCM", 5 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	<%=ESysLib.SetGridColumnComboFormat("grdCM", 20,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 

	// OTHER
	<%=ESysLib.SetGridColumnComboFormat("grdOther", 14,"SELECT CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'TPS0022' AND A.DEL_IF = 0 AND B.DEL_IF = 0 AND B.USE_YN ='Y' ORDER BY CODE, B.CODE_NM")%>; 
	<%=ESysLib.SetGridColumnComboFormat("grdOther", 6 ,"SELECT A.UOM_CODE, DECODE(NVL(A.CNV_RATIO,1),1,'',TO_CHAR(NVL(A.CNV_RATIO,1),'9,990'))|| ' ' || A.UOM_NM  FROM COMM.TCO_UOM A WHERE DEL_IF=0")%>; 
	<%=ESysLib.SetGridColumnComboFormat("grdOther", 7,"SELECT A.CODE, A.CODE FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE")%>; 

}
//===========================================================================================================================
function  Hide()
{
			txtCont_more.SetEnable(false);
			txtCont_less.SetEnable(false);
			lstUP.SetEnable(false);
			txtWkng_more.SetEnable(false);
			txtWkng_less.SetEnable(false);
			
			txtWkngUP_Fr.SetEnable(false);
			txtWkngUP_To.SetEnable(false);
			lstPriceRange.SetEnable(false);
			txtBCWS_Fr.SetEnable(false);
			txtBCWS_To.SetEnable(false);
			
			txtD_more.SetEnable(false);
			txtD_less.SetEnable(false);
}
//===========================================================================================================================
function OnVisible(obj)
{
			switch(obj)
			{
					case 'Qty_1':
							if(chkQty_1.value == 'N')
							{
									if(chkQty_2.value == 'Y')
									{
										
									}
									else
									{
											chkCont_more.SetEnable(true);
											chkCont_less.SetEnable(true);	
											chkWkng_more.SetEnable(true);	
											chkWkng_less.SetEnable(true);	
											chkWkngUP.SetEnable(true);	
											chkBCWS.SetEnable(true);	
									}
							}
							else
							{
									if(chkQty_2.value == 'Y')
									{
										
									}
									else
									{
											chkCont_more.SetEnable(false);
											chkCont_less.SetEnable(false);	
											chkWkng_more.SetEnable(false);	
											chkWkng_less.SetEnable(false);	
											chkWkngUP.SetEnable(false);	
											chkBCWS.SetEnable(false);	
									}
							}
					break;
					case 'Qty_2':
							if(chkQty_2.value == 'N')
							{
										if(chkQty_1.value  == 'N')
										{
											chkCont_more.SetEnable(true);
											chkCont_less.SetEnable(true);	
										}
										else
										{
												chkWkng_more.SetEnable(false);	
												chkWkng_less.SetEnable(false);	
												chkWkngUP.SetEnable(false);	
												chkBCWS.SetEnable(false);	
										}
							}
							else
							{
									if(chkQty_1.value  == 'N')
									{
										chkCont_more.SetEnable(false);
										chkCont_less.SetEnable(false);	
									}
									else
									{
											chkWkng_more.SetEnable(true);	
											chkWkng_less.SetEnable(true);	
											chkWkngUP.SetEnable(true);	
											chkBCWS.SetEnable(true);	
									}
							}
					break;
					case 'Qty_3':
							if(chkQty_3.value == 'Y')
							{
									if(chkQty_2.value == 'N')
									{
										
									}
									else
									{
										chkCont_more.SetEnable(true);
										chkCont_less.SetEnable(true);	
									}
							}
							else
							{
									if(chkQty_2.value == 'Y')
									{
										chkCont_more.SetEnable(false);
										chkCont_less.SetEnable(false);	
									}
									else
									{
										return;
									}
							}
					break;
					case 'Cont_more':
							if(chkCont_more.value == 'Y')
							{
									if((chkWkng_more.value == 'Y') || (chkWkng_less.value == 'Y'))
									{
												lstUP.SetEnable(true);
									}
									txtCont_more.SetEnable(true);
									txtCont_more.GetControl().focus();
									Cmore.style.background='#F69';
							}
							else
							{
									if((chkWkng_more.value == 'N') || (chkWkng_less.value == 'N')  || ((chkWkng_less.value == 'Y') &&  (chkWkng_more.value == 'Y')  && (chkCont_less.value == 'N')) )
									{
												lstUP.SetEnable(false);
									}
									txtCont_more.SetEnable(false);
									Cmore.style.background='';
							}
					break;
					case 'Cont_less':
							if(chkCont_less.value == 'Y')
							{
									if((chkWkng_more.value == 'Y') || (chkWkng_less.value == 'Y'))
									{
												lstUP.SetEnable(true);
									}
									txtCont_less.SetEnable(true);
									txtCont_less.GetControl().focus();
									Cless.style.background='#F69';
							}
							else
							{
									if((chkWkng_more.value == 'N') || (chkWkng_less.value == 'N')   || ((chkWkng_less.value == 'Y') &&  (chkWkng_more.value == 'Y')  && (chkCont_more.value == 'N'))    )
									{
												lstUP.SetEnable(false);
									}
									txtCont_less.SetEnable(false);
									Cless.style.background='';
							}
					break;
					case 'Wkng_more':
							if(chkWkng_more.value == 'Y')
							{
									if((chkCont_less.value == 'Y') || (chkCont_more.value == 'Y'))
									{
												lstUP.SetEnable(true);
									}
									txtWkng_more.SetEnable(true);
									txtWkng_more.GetControl().focus();
									Wmore.style.background='#F69';
							}
							else
							{
									if(    (chkCont_less.value == 'N') || (chkCont_more.value == 'N')   || ((chkCont_less.value == 'Y') &&  (chkCont_more.value == 'Y')  && (chkWkng_less.value == 'N'))      )
									{
												lstUP.SetEnable(false);
									}
									txtWkng_more.SetEnable(false);
									Wmore.style.background='';
							}
					break;
					case 'Wkng_less':
							if(chkWkng_less.value == 'Y')
							{
									if((chkCont_less.value == 'Y') || (chkCont_more.value == 'Y') )
									{
												lstUP.SetEnable(true);
									}
									txtWkng_less.SetEnable(true);
									txtWkng_less.GetControl().focus();
									Wless.style.background='#F69';
							}
							else
							{
									if(  (chkCont_less.value == 'N') || (chkCont_more.value == 'N') ||  ((chkCont_less.value == 'Y') &&  (chkCont_more.value == 'Y')  && (chkWkng_more.value == 'N'))  )
									{
												lstUP.SetEnable(false);
									}
									txtWkng_less.SetEnable(false);
									Wless.style.background='';
							}
					break;
					case 'WkngUP':
							if(chkWkngUP.value == 'Y')
							{
									if((chkBCWS.value == 'Y'))
									{
												lstPriceRange.SetEnable(true);
									}
									txtWkngUP_Fr.SetEnable(true);
									txtWkngUP_To.SetEnable(true);
									WkngUP_Fr.style.background='#F69';
									WkngUP_To.style.background='#F69';
							}
							else
							{
									if((chkBCWS.value == 'Y'))
									{
												lstPriceRange.SetEnable(false);
									}
									txtWkngUP_Fr.SetEnable(false);
									//txtWkngUP_Fr.SetDataText('');
									txtWkngUP_To.SetEnable(false);
									//txtWkngUP_To.SetDataText('');
									//lstPriceRange.SetDataText('');		
									WkngUP_Fr.style.background='';
									WkngUP_To.style.background='';
							}
					break;
					case 'BCWS':
							if(chkBCWS.value == 'Y')
							{
									if((chkWkngUP.value == 'Y'))
									{
												lstPriceRange.SetEnable(true);
									}
									txtBCWS_Fr.SetEnable(true);
									txtBCWS_To.SetEnable(true);
									BCWS_Fr.style.background='#F69';
									BCWS_To.style.background='#F69';
							}
							else
							{
									if((chkWkngUP.value == 'Y'))
									{
												lstPriceRange.SetEnable(false);
									}
									txtBCWS_Fr.SetEnable(false);
									//txtBCWS_Fr.SetDataText('');
									txtBCWS_To.SetEnable(false);
									//txtBCWS_To.SetDataText('');
									//lstPriceRange.SetDataText('');		
									BCWS_Fr.style.background='';
									BCWS_To.style.background='';
							}
					break;
					case 'Design_more':
							if(chkD_more.value == 'Y')
							{
									txtD_more.SetEnable(true);
									txtD_more.GetControl().focus();
									Dmore.style.background='#F69';
							}
							else
							{
										txtD_more.SetEnable(false);
										Dmore.style.background='';
							}
					break;
					case 'Design_less':
							if(chkD_less.value == 'Y')
							{
									txtD_less.SetEnable(true);
									txtD_less.GetControl().focus();
									Dless.style.background='#F69';
							}
							else
							{
										txtD_less.SetEnable(false);
										Dless.style.background='';
							}
					break;
			}
}
//===========================================================================================================================
var show = 'T';
function ShowHide() 
{
		var vendor1 = document.all("info_1"); 
		var vendor2 = document.all("info_2"); 
		var vendor3 = document.all("info_3"); 
		var vendor4= document.all("info_4"); 
		if(idTab.GetCurrentPageNo() == 0)
		{
					if (vendor4.style.display == "none")
   					 {
							vendor1.style.display = "none";
							vendor2.style.display = "none";
							vendor3.style.display = "none";
							vendor4.style.display = "";
							imgup.src = "../../../system/images/up.gif";
							show = 'T';
					 }
						else
						{
							vendor1.style.display = "none";
							vendor2.style.display = "none";
							vendor3.style.display = "none";
							vendor4.style.display = "none";
							imgup.src = "../../../system/images/down.gif";
							show = 'F';
						}
		}
		else if(  (idTab.GetCurrentPageNo() == 1)  || (idTab.GetCurrentPageNo() == 2)  || (idTab.GetCurrentPageNo() == 4) )
		{
						if (vendor1.style.display == "none" )
   					 {
							vendor1.style.display = "";
							vendor2.style.display = "";
							vendor3.style.display = "";
							vendor4.style.display = "none";
							imgup.src = "../../../system/images/up.gif";
							show = 'T';
					 }
						else
						{
							vendor1.style.display = "none";
							vendor2.style.display = "none";
							vendor3.style.display = "none";
							vendor4.style.display = "none";
							imgup.src = "../../../system/images/down.gif";
							show = 'F';
						}
		}
}
//===========================================================================================================================
function OnShow() 
{
		var vendor1 = document.all("info_1"); 
		var vendor2 = document.all("info_2"); 
		var vendor3 = document.all("info_3"); 
		var vendor4= document.all("info_4"); 
		if(idTab.GetCurrentPageNo() == 0)
		{
				if(show == 'T')
				{
							vendor1.style.display = "none";
							vendor2.style.display = "none";
							vendor3.style.display = "none";
							vendor4.style.display = "";
							imgup.src = "../../../system/images/up.gif";
				}
		}
	   else if(  (idTab.GetCurrentPageNo() == 1) ||  (idTab.GetCurrentPageNo() == 2)  ||  (idTab.GetCurrentPageNo() == 4)    )
		{
				if(show == 'T')
				{
							vendor1.style.display = "";
							vendor2.style.display = "";
							vendor3.style.display = "";
							vendor4.style.display = "none";
							imgup.src = "../../../system/images/up.gif";
				}
		}
		else
		{
				
							vendor1.style.display = "none";
							vendor2.style.display = "none";
							vendor3.style.display = "none";
							vendor4.style.display = "none";
				
		}
}
//===========================================================================================================================
function Merge_grid(obj)
{
	switch(obj.id)
	{
		case 'grdEQ':
			if (obj.rows < 2)
			{		
				obj.AddRow();
			}

			var fg = obj.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5

			fg.MergeCol(EQ_PK) = true
			fg.Cell(0, 0, EQ_PK, 1, EQ_PK)				= "PK"

			fg.MergeCol(EQ_LEVEL_PK) = true
			fg.Cell(0, 0, EQ_LEVEL_PK, 1, EQ_LEVEL_PK)	= "LEVEL_PK"

			fg.MergeCol(EQ_LEVEL) = true
			fg.Cell(0, 0, EQ_LEVEL, 1, EQ_LEVEL)		= "Level"
			
			fg.MergeCol(EQ_ITEM_NO) = true
			fg.Cell(0, 0, EQ_ITEM_NO, 1, EQ_ITEM_NO)	= "Item No."

			fg.MergeCol(EQ_NAME) = true
			fg.Cell(0, 0, EQ_NAME, 1, EQ_NAME)			= "Name"
			
			fg.MergeCol(EQ_STANDARD) = true
			fg.Cell(0, 0, EQ_STANDARD, 1, EQ_STANDARD)	= "Standard"
			
			fg.MergeCol(EQ_WEIGHT) = true
			fg.Cell(0, 0, EQ_WEIGHT, 1, EQ_WEIGHT)		= "Weight"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, EQ_UOM, 0, EQ_AMT) = "Working(Changed)"  
			fg.Cell(0, 1, EQ_UOM, 1) 		 = "Unit"
			fg.Cell(0, 1, EQ_CCY, 1) 		 = "CCY"
			fg.Cell(0, 1, EQ_QTY, 1 ) 		 = "Quantity"
			fg.Cell(0, 1, EQ_UNIT_COST, 1) 	 = "Unit Cost"
			fg.Cell(0, 1, EQ_AMT, 1) 		 = "Amount"			
			
			fg.MergeCol(EQ_ORDER_PK) = true
			fg.Cell(0, 0, EQ_ORDER_PK, 1, EQ_ORDER_PK) = "ORDER_PK"

			fg.MergeRow(0) = true
			fg.Cell(0, 0, EQ_ORDER_CODE, 0, EQ_ORDER_NAME) = "Order W. Div."  
			fg.Cell(0, 1, EQ_ORDER_CODE, 1) 	= "Code"
			fg.Cell(0, 1, EQ_ORDER_NAME, 1 ) 	= "Name"
			
			fg.MergeCol(EQ_EX_YN) = true
			fg.Cell(0, 0, EQ_EX_YN, 1, EQ_EX_YN) = "Excution (Yes/No)"

			fg.MergeCol(EQ_BUDGET_PK) = true
			fg.Cell(0, 0, EQ_BUDGET_PK, 1, EQ_BUDGET_PK) = "BUDGET_PK"

			fg.MergeCol(EQ_BUDGET_CODE) = true
			fg.Cell(0, 0, EQ_BUDGET_CODE, 1, EQ_BUDGET_CODE) = "Budget Code"
			
			fg.MergeCol(EQ_STANDARD_PBS) = true
			fg.Cell(0, 0, EQ_STANDARD_PBS, 1, EQ_STANDARD_PBS) = "Standard PBS"
			
			fg.MergeCol(EQ_DEVL_TERM) = true
			fg.Cell(0, 0, EQ_DEVL_TERM, 1, EQ_DEVL_TERM) = "Delivery Term"
			
			fg.MergeCol(EQ_ORDER_STATUS) = true
			fg.Cell(0, 0, EQ_ORDER_STATUS, 1, EQ_ORDER_STATUS) = "Order Status"
			
			fg.MergeCol(EQ_RSLT_YN) = true
			fg.Cell(0, 0, EQ_RSLT_YN, 1, EQ_RSLT_YN) = "A. Rslt Rcpt (Y/N)"
			
			fg.MergeCol(EQ_PROJECT_PK) = true
			fg.Cell(0, 0, EQ_PROJECT_PK, 1, EQ_PROJECT_PK) = "A. Rslt Rcpt (Y/N)"

			fg.MergeCol(EQ_PROJECT_PK) = true
			fg.Cell(0, 0, EQ_PROJECT_PK, 1, EQ_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(EQ_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, EQ_TECPS_UNDERTAKECTRTBASC_PK, 1, EQ_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(EQ_UNDERTAKESEQ) = true
			fg.Cell(0, 0, EQ_UNDERTAKESEQ, 1, EQ_UNDERTAKESEQ) = "UNDERTAKE_SEQ"

			fg.MergeCol(EQ_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, EQ_TECPS_PERFORMBUDGETBASC_PK, 1, EQ_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"
			
			fg.MergeCol(EQ_BOOKING_AMT) = true
			fg.Cell(0, 0, EQ_BOOKING_AMT, 1, EQ_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(EQ_SEQ_NO) = true
			fg.Cell(0, 0, EQ_SEQ_NO, 1, EQ_SEQ_NO) = "SEQ"

			fg.MergeCol(EQ_NUM) = true
			fg.Cell(0, 0, EQ_NUM, 1, EQ_NUM) = "NUM"

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(EQ_WEIGHT)	= 7;
			ctrl.ColAlignment(EQ_QTY)		= 7;
			ctrl.ColAlignment(EQ_UNIT_COST)	= 7;
			ctrl.ColAlignment(EQ_AMT)		= 7;
			
			ctrl.ColFormat(EQ_WEIGHT)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(EQ_QTY)			= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(EQ_UNIT_COST)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(EQ_AMT)			= "#,###,###,###,###,###,###,###,###.##R";
			break;
		case 'grdCONS':
			if (grdCONS.rows < 2)
			{		
				grdCONS.AddRow();
			}
			
			var fg = grdCONS.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5

			fg.MergeCol(CONS_PK) = true
			fg.Cell(0, 0, CONS_PK, 1, CONS_PK) = "PK"

			fg.MergeCol(CONS_TAKE_LEVEL) = true
			fg.Cell(0, 0, CONS_TAKE_LEVEL, 1, CONS_TAKE_LEVEL) = "Level_PK"

			fg.MergeCol(CONS_LEVEL) = true
			fg.Cell(0, 0, CONS_LEVEL, 1, CONS_LEVEL) = "Level"

			fg.MergeCol(CONS_CODE) = true
			fg.Cell(0, 0, CONS_CODE, 1, CONS_CODE) = "Code"

			fg.MergeCol(CONS_NAME) = true
			fg.Cell(0, 0, CONS_NAME, 1, CONS_NAME) = "Name"

			fg.MergeCol(CONS_STAN) = true
			fg.Cell(0, 0, CONS_STAN, 1, CONS_STAN) = "Standard"	
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, CONS_UNIT, 0, CONS_AMT)	= "Working(Changed)"
			fg.Cell(0, 1, CONS_UNIT, 1) 			= "Unit"
			fg.Cell(0, 1, CONS_CCY, 1 ) 			= "Currency"
			fg.Cell(0, 1, CONS_QTY, 1) 				= "Qty"
			fg.Cell(0, 1, CONS_UNIT_PRICE, 1) 		= "---"
			fg.Cell(0, 1, CONS_RAW, 1) 				= "Raw Mtrl. Cost U/P"
			fg.Cell(0, 1, CONS_LABOR, 1) 			= "Labor Cost U/P"
			fg.Cell(0, 1, CONS_EXP_UP, 1) 			= "Exp. U/P"
			fg.Cell(0, 1, CONS_LABOR_UNIT_PRICE, 1) = "Unit Price"
			fg.Cell(0, 1, CONS_AMT, 1) 				= "Amount"

			fg.Cell(0, 0, CONS_ORDER_PK, 0, CONS_ORDER_NAME) = "Order W. Div." 
			fg.Cell(0, 1, CONS_ORDER_PK, 1) 	= "PK"
			fg.Cell(0, 1, CONS_ORDER_CODE, 1) 	= "Code"
			fg.Cell(0, 1, CONS_ORDER_NAME, 1 ) 	= "Name"
			
			fg.MergeCol(CONS_EXEC_YN) = true
			fg.Cell(0, 0, CONS_EXEC_YN, 1, CONS_EXEC_YN) = "Exec. (Y/N)"
			
			fg.MergeCol(CONS_DIR_MGT) = true
			fg.Cell(0, 0, CONS_DIR_MGT, 1, CONS_DIR_MGT) = "Dir. Mgt Outsrc."
			
			fg.MergeCol(CONS_BUDGET_PK) = true
			fg.Cell(0, 0, CONS_BUDGET_PK, 1, CONS_BUDGET_PK) = "Budget_PK"

			fg.MergeCol(CONS_BUDGET_CODE) = true
			fg.Cell(0, 0, CONS_BUDGET_CODE, 1, CONS_BUDGET_CODE) = "Budget Code"
			
			fg.MergeCol(CONS_STAN_CODE) = true
			fg.Cell(0, 0, CONS_STAN_CODE, 1, CONS_STAN_CODE) = "Standard Code"
			
			fg.MergeCol(CONS_CALC_BASIC) = true
			fg.Cell(0, 0, CONS_CALC_BASIC, 1, CONS_CALC_BASIC) = "Calc. Basic"
			
			fg.MergeCol(CONS_ORDER_STA) = true
			fg.Cell(0, 0, CONS_ORDER_STA, 1, CONS_ORDER_STA) = "Order Status"
			
			fg.MergeCol(CONS_RSLT_YN) = true
			fg.Cell(0, 0, CONS_RSLT_YN, 1, CONS_RSLT_YN) = "A. Rslt Rcpt Y/N"				

			fg.MergeCol(CONS_PROJECT_PK) = true
			fg.Cell(0, 0, CONS_PROJECT_PK, 1, CONS_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(CONS_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, CONS_TECPS_UNDERTAKECTRTBASC_PK, 1, CONS_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(CONS_UNDERTAKESEQ) = true
			fg.Cell(0, 0, CONS_UNDERTAKESEQ, 1, CONS_UNDERTAKESEQ) = "UNDERTAKE_SEQ"

			fg.MergeCol(CONS_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, CONS_TECPS_PERFORMBUDGETBASC_PK, 1, CONS_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"

			fg.MergeCol(CONS_BOOKING_AMT) = true
			fg.Cell(0, 0, CONS_BOOKING_AMT, 1, CONS_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(CONS_SEQ_NO) = true
			fg.Cell(0, 0, CONS_SEQ_NO, 1, CONS_SEQ_NO) = "SEQ"

			fg.MergeCol(CONS_NUM) = true
			fg.Cell(0, 0, CONS_NUM, 1, CONS_NUM) = "NUM"

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(CONS_QTY)			= 7;
			ctrl.ColAlignment(CONS_UNIT_PRICE)	= 7;
			ctrl.ColAlignment(CONS_RAW)			= 7;
			ctrl.ColAlignment(CONS_LABOR)		= 7;
			ctrl.ColAlignment(CONS_EXP_UP)		= 7;
			ctrl.ColAlignment(CONS_LABOR_UNIT_PRICE) = 7;
			ctrl.ColAlignment(CONS_AMT)			= 7;
			ctrl.ColAlignment(CONS_CALC_BASIC)  = 7;
			ctrl.ColAlignment(CONS_CCY)			= 2;

			ctrl.ColFormat(CONS_QTY)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_UNIT_PRICE)			= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_RAW)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_LABOR)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_EXP_UP)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_LABOR_UNIT_PRICE)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_AMT)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CONS_CALC_BASIC)			= "#,###,###,###,###,###,###,###,###.##R";
		break;

		case 'grdCM':
			if (grdCM.rows < 2)
			{		
				grdCM.AddRow();
			}
			
			var fg = grdCM.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5

			fg.MergeCol(CM_PK) = true
			fg.Cell(0, 0, CM_PK, 1, CM_PK) = "PK"

			fg.MergeCol(CM_NO) = true
			fg.Cell(0, 0, CM_NO, 1, CM_NO) = "No"

			fg.MergeCol(CM_DES) = true
			fg.Cell(0, 0, CM_DES, 1, CM_DES) = "Description"

			fg.MergeCol(CM_LEVEL_PK) = true
			fg.Cell(0, 0, CM_LEVEL_PK, 1, CM_LEVEL_PK) = "LEVEL_PK"

			fg.MergeCol(CM_NAME) = true
			fg.Cell(0, 0, CM_NAME, 1, CM_NAME) = "Name"
			
			fg.MergeCol(CM_UOM) = true
			fg.Cell(0, 0, CM_UOM, 1, CM_UOM) = "UOM"
			
			fg.MergeCol(CM_QTY) = true
			fg.Cell(0, 0, CM_QTY, 1, CM_QTY) = "Quatity"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, CM_DIRECT_CCY, 0, CM_DIRECT_AMT)	= "Direct Management"  
			fg.Cell(0, 1, CM_DIRECT_CCY, 1) 				= "Ccy"
			fg.Cell(0, 1, CM_DIRECT_MM, 1 ) 				= "MM"
			fg.Cell(0, 1, CM_DIRECT_UNIT_COST, 1) 			= "Unit Cost"
			fg.Cell(0, 1, CM_DIRECT_AMT, 1) 				= "Amount"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, CM_OUTSRC_CCY, 0, CM_OUTSRC_AMT)	= "Outsrc."  
			fg.Cell(0, 1, CM_OUTSRC_CCY, 1) 				= "Ccy"
			fg.Cell(0, 1, CM_OUTSRC_MM, 1 ) 				= "MM"
			fg.Cell(0, 1, CM_OUTSRC_UNIT_COST, 1) 			= "Unit Cost"
			fg.Cell(0, 1, CM_OUTSRC_AMT, 1 ) 				= "Amount"
			
			fg.MergeCol(CM_SUM) = true
			fg.Cell(0, 0, CM_SUM, 1, CM_SUM) = "Sum"
			
			fg.MergeCol(CM_OUTSITE_PK) = true
			fg.Cell(0, 0, CM_OUTSITE_PK, 1, CM_OUTSITE_PK) = "OUTSITE_PK"

			fg.MergeRow(0) = true
			fg.Cell(0, 0, CM_OUTSITE_CODE, 0, CM_OUTSITE_NAME) = "Outside Work"  
			fg.Cell(0, 1, CM_OUTSITE_CODE, 1) 					= "Code"
			fg.Cell(0, 1, CM_OUTSITE_NAME, 1 ) 				= "Name"
			
			fg.MergeCol(CM_ORDER_STATUS) = true
			fg.Cell(0, 0, CM_ORDER_STATUS, 1, CM_ORDER_STATUS) = "Order Status"
			
			fg.MergeCol(CM_RSLT_YN) = true
			fg.Cell(0, 0, CM_RSLT_YN, 1, CM_RSLT_YN) = "A. Rslt Rcpt (Y/N)"

			fg.MergeCol(CM_PROJECT_PK) = true
			fg.Cell(0, 0, CM_PROJECT_PK, 1, CM_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(CM_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, CM_TECPS_UNDERTAKECTRTBASC_PK, 1, CM_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(CM_UNDERTAKESEQ) = true
			fg.Cell(0, 0, CM_UNDERTAKESEQ, 1, CM_UNDERTAKESEQ) = "UNDERTAKE_SEQ"

			fg.MergeCol(CM_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, CM_TECPS_PERFORMBUDGETBASC_PK, 1, CM_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"

			fg.MergeCol(CM_BOOKING_AMT) = true
			fg.Cell(0, 0, CM_BOOKING_AMT, 1, CM_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(CM_SEQ_NO) = true
			fg.Cell(0, 0, CM_SEQ_NO, 1, CM_SEQ_NO) = "SEQ"

			fg.MergeCol(CM_NUM) = true
			fg.Cell(0, 0, CM_NUM, 1, CM_NUM) = "NUM"

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(CM_QTY)				= 7;
			ctrl.ColAlignment(CM_DIRECT_MM)			= 7;
			ctrl.ColAlignment(CM_DIRECT_UNIT_COST)	= 7;
			ctrl.ColAlignment(CM_DIRECT_AMT)		= 7;
			ctrl.ColAlignment(CM_OUTSRC_MM)			= 7;
			ctrl.ColAlignment(CM_OUTSRC_UNIT_COST)	= 7;
			ctrl.ColAlignment(CM_OUTSRC_AMT)		= 7;
			ctrl.ColAlignment(CM_SUM)				= 7;

			ctrl.ColFormat(CM_QTY)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_DIRECT_MM)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_DIRECT_UNIT_COST)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_DIRECT_AMT)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_OUTSRC_MM)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_OUTSRC_UNIT_COST)	= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_OUTSRC_AMT)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(CM_SUM)				= "#,###,###,###,###,###,###,###,###.##R";
		break;
		case 'grdOther':
			if (grdOther.rows < 2)
			{		
				grdOther.AddRow();
			}
			
			var fg = grdOther.GetGridControl();
			fg.FixedRows = 2
			fg.MergeCells = 5
	
			fg.MergeCol(OTHER_PK) = true
			fg.Cell(0, 0, OTHER_PK, 1, OTHER_PK) = "PK"

			fg.MergeCol(OTHER_LEVEL_PK) = true
			fg.Cell(0, 0, OTHER_LEVEL_PK, 1, OTHER_LEVEL_PK) = "LEVEL_PK"

			fg.MergeCol(OTHER_LEVEL) = true
			fg.Cell(0, 0, OTHER_LEVEL, 1, OTHER_LEVEL) = "Level"
			
			fg.MergeCol(OTHER_SRVC_FLD) = true
			fg.Cell(0, 0, OTHER_SRVC_FLD, 1, OTHER_SRVC_FLD) = "Other Srvc Fld"

			fg.MergeCol(OTHER_NAME) = true
			fg.Cell(0, 0, OTHER_NAME, 1, OTHER_NAME) = "Name"
			
			fg.MergeCol(OTHER_STANDARD) = true
			fg.Cell(0, 0, OTHER_STANDARD, 1, OTHER_STANDARD) = "Standard"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, OTHER_UNIT, 0, OTHER_AMT) = "Execution(adjustment)"  
			fg.Cell(0, 1, OTHER_UNIT, 1) 	= "Unit"
			fg.Cell(0, 1, OTHER_CCY, 1) 	= "CYY"
			fg.Cell(0, 1, OTHER_QTY, 1) 	= "Q'ty"
			fg.Cell(0, 1, OTHER_UNIT_PRICE, 1) 	= "U/P"
			fg.Cell(0, 1, OTHER_AMT, 1) 	= "Amount"
			
			fg.MergeCol(OTHER_ORDER_PK) = true
			fg.Cell(0, 0, OTHER_ORDER_PK, 1, OTHER_ORDER_PK) = "ORDER_PK"
			
			fg.MergeRow(0) = true
			fg.Cell(0, 0, OTHER_ORDER_CODE, 0, OTHER_ORDER_NAME) = "Order W. Div."  
			fg.Cell(0, 1, OTHER_ORDER_CODE, 1) 	= "Code"
			fg.Cell(0, 1, OTHER_ORDER_NAME, 1 ) 	= "Name"
			
			fg.MergeCol(OTHER_ORDER_STATUS) = true
			fg.Cell(0, 0, OTHER_ORDER_STATUS, 1, OTHER_ORDER_STATUS) = "Order Status"

			fg.MergeCol(OTHER_RSLT_YN) = true
			fg.Cell(0, 0, OTHER_RSLT_YN, 1, OTHER_RSLT_YN) = "A. Rslt Rcpt (Y/N)"
			
			fg.MergeCol(OTHER_PROJECT_PK) = true
			fg.Cell(0, 0, OTHER_PROJECT_PK, 1, OTHER_PROJECT_PK) = "PROJECT_PK"

			fg.MergeCol(OTHER_TECPS_UNDERTAKECTRTBASC_PK) = true
			fg.Cell(0, 0, OTHER_TECPS_UNDERTAKECTRTBASC_PK, 1, OTHER_TECPS_UNDERTAKECTRTBASC_PK) = "TECPS_UNDERTAKECTRTBASC_PK"

			fg.MergeCol(OTHER_UNDERTAKESEQ) = true
			fg.Cell(0, 0, OTHER_UNDERTAKESEQ, 1, OTHER_UNDERTAKESEQ) = "UNDERTAKE_SEQ"
			
			fg.MergeCol(OTHER_TECPS_PERFORMBUDGETBASC_PK) = true
			fg.Cell(0, 0, OTHER_TECPS_PERFORMBUDGETBASC_PK, 1, OTHER_TECPS_PERFORMBUDGETBASC_PK) = "BUDGETMST_PK"

			fg.MergeCol(OTHER_BOOKING_AMT) = true
			fg.Cell(0, 0, OTHER_BOOKING_AMT, 1, OTHER_BOOKING_AMT) = "BOOKING_AMT"

			fg.MergeCol(OTHER_SEQ_NO) = true
			fg.Cell(0, 0, OTHER_SEQ_NO, 1, OTHER_SEQ_NO) = "SEQ"

			fg.MergeCol(OTHER_NUM) = true
			fg.Cell(0, 0, OTHER_NUM, 1, OTHER_NUM) = "NUM"

			var ctrl = obj.GetGridControl();
			ctrl.ColAlignment(OTHER_QTY)			= 7;
			ctrl.ColAlignment(OTHER_UNIT_PRICE)		= 7;
			ctrl.ColAlignment(OTHER_AMT)			= 7;

			ctrl.ColFormat(OTHER_QTY)				= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(OTHER_UNIT_PRICE)		= "#,###,###,###,###,###,###,###,###.##R";
			ctrl.ColFormat(OTHER_AMT)				= "#,###,###,###,###,###,###,###,###.##R";
		break;
	}	
}
//===========================================================================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'project':
		    var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
		    var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
		    if ( object != null )
		    {
			    txtProjectPk.text = object[0];
                txtProject_Cd.text = object[1];
                txtProject_Nm.text = object[2];
				//OnSearch('MST');
				dso_version.Call();
		    }
	    break;
        case 'Work_Breakdown':
            var path = System.RootURL + '/form/kp/bp/kpbp00050Work_Breakdown.aspx?Project_Pk=' + txtProjectPk.text;
            var obj = System.OpenModal( path ,600 , 600 , 'resizable:yes;status:yes');
            if ( obj != null )
            {
			    if (obj[2] != 0)
			    {
				    lstWork_Breakdown.SetDataText(obj[2]);
			    }   
            }
        break;
        case 'OutsideOrderWork':
			if (txtProjectPk.text == '' )
			{
				alert('Please select Project !!');
			}
			else
			{
				var path = System.RootURL + "/form/kp/bm/kpbm00050_Order_W_Div.aspx?p_project_pk="+ txtProjectPk.text;
				var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
				 
				if (object != null)
				{
					txtOrderWork_Cd.text = object[1];
					txtOrderWork_Nm.text = object[2];
					txtOrderWork_Pk.text = object[0];
				}
			}
        break;
		case 'Version':
			if (txtProjectPk.text == '' )
			{
				alert('Please select Project !!');
			}
			else
			{
				var fpath = System.RootURL + "/form/kp/bp/kpbp00020_popup_Version.aspx?Project_Pk=" + txtProjectPk.text;
				var aValue = System.OpenModal( fpath , 700 , 500 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
				if(aValue != null)
				{
					txtContract_Pk.text		= aValue[0];
					txtContract_Seq.text	= aValue[1];
				} 
			} 
		break;
    }    
}
//===========================================================================================================================
function OnSearch(idTab)
{
	if (txtProjectPk.text == '')
	{
		alert('Please, select Project !!!');
		return;
	}
	switch(idTab.GetCurrentPageNo())
	{
		case 1:
//            if(chkWkngUP.value == 'N' || chkBCWS.value == 'N')
//			{
//				lstPriceRange.SetDataText('');		
//                txtWkngUP_Fr.SetDataText('');		
//                txtWkngUP_To.SetDataText('');	
//                txtBCWS_Fr.SetDataText('');			
//                txtBCWS_To.SetDataText('');	
//			}			
			dso_grdEQ.Call('SELECT');
		break;	
		case 2:
			dso_grdCONS.Call('SELECT');
		break;
		case 3:
			dso_grdCM.Call('SELECT');
		break;
		case 4:
			dso_grdOther.Call('SELECT');
		break;
	}
}
//===========================================================================================================================
function OnChangeCB()
{ 
	flag = 'SELECT';
	switch (idTab.GetCurrentPageNo())
	{
		case 0:
			dso_grdEQ.Call('SELECT');
		break;
		case 1:
			dso_grdCONS.Call('SELECT');
		break;
		case 2:
			dso_grdCM.Call('SELECT');
		break;
		case 3:
			dso_grdOther.Call('SELECT');
		break;
	}
}
//===========================================================================================================================
function OnReceiveData(obj)
{
	switch(obj.id)
	{
		case 'dso_grdEQ':
				Merge_grid(grdEQ);
		break;
        case 'dso_grdCONS':
            Merge_grid(grdCONS);
        break;
        case 'dso_grdCM':
            Merge_grid(grdCM);
        break;
        case 'dso_grdOther':
            Merge_grid(grdOther);
        break;
	}
}

function OnCheckCol(n)
{
	switch(idTab.GetCurrentPageNo())
	{
		case 1:			
			var fg = grdEQ.GetGridControl(); 
			switch(n)
			{
				case 1:
					if (chk1.value == 'Y')
						fg.ColHidden(EQ_LEVEL) = false;
					else
						fg.ColHidden(EQ_LEVEL) = true;
				break;
				case 2:
					if (chk2.value == 'Y')
						fg.ColHidden(EQ_STANDARD) = false;
					else
						fg.ColHidden(EQ_STANDARD) = true;
				break;
				case 3:
					if (chk3.value == 'Y')
						fg.ColHidden(EQ_WEIGHT) = false;
					else
						fg.ColHidden(EQ_WEIGHT) = true;
				break;
				case 4:

				break;
				case 5:

				break;
				case 6:					
					if (chk6.value == 'Y')
					{
						fg.ColHidden(EQ_ORDER_CODE) = false;
						fg.ColHidden(EQ_ORDER_NAME) = false;
					}
					else
					{
						fg.ColHidden(EQ_ORDER_CODE) = true;
						fg.ColHidden(EQ_ORDER_NAME) = true;
					}
				break;
				case 7:
					if (chk7.value == 'Y')
						fg.ColHidden(EQ_EX_YN) = false;
					else
						fg.ColHidden(EQ_EX_YN) = true;
				break;
				case 8:
					if (chk8.value == 'Y')
						fg.ColHidden(EQ_BUDGET_CODE) = false;
					else
						fg.ColHidden(EQ_BUDGET_CODE) = true;
				break;
				case 9:
					if (chk9.value == 'Y')
						fg.ColHidden(EQ_STANDARD_PBS) = false;
					else
						fg.ColHidden(EQ_STANDARD_PBS) = true;	
				break;
				case 10:
					if (chk10.value == 'Y')
						fg.ColHidden(EQ_DEVL_TERM) = false;
					else
						fg.ColHidden(EQ_DEVL_TERM) = true;
				break;
				case 11:
					if (chk11.value == 'Y')
						fg.ColHidden(EQ_RSLT_YN) = false;
					else
						fg.ColHidden(EQ_RSLT_YN) = true;
				break;
				case 12:

				break;
			}
		break;
		case 2:
			var fg = grdCONS.GetGridControl(); 
			switch (n)
			{
				case 1:
					if (chk21.value == 'Y')
						fg.ColHidden(CONS_LEVEL) = false;
					else
						fg.ColHidden(CONS_LEVEL) = true;
				break;	
				case 2:
					if (chk22.value == 'Y')
						fg.ColHidden(CONS_STAN) = false;
					else
						fg.ColHidden(CONS_STAN) = true;				
				break;
				case 3:
					if (chk23.value == 'Y')
					{
						fg.ColHidden(CONS_RAW) = false;
						fg.ColHidden(CONS_LABOR) = false;
						fg.ColHidden(CONS_EXP_UP) = false;
					}
					else
					{
						fg.ColHidden(CONS_RAW) = true;	
						fg.ColHidden(CONS_LABOR) = true;	
						fg.ColHidden(CONS_EXP_UP) = true;	
					}
				break;
				case 4:
					if (chk24.value == 'Y')
					{
						fg.ColHidden(CONS_ORDER_CODE) = false;
						fg.ColHidden(CONS_ORDER_NAME) = false;
					}
					else
					{
						fg.ColHidden(CONS_ORDER_CODE) = true;
						fg.ColHidden(CONS_ORDER_NAME) = true;
					}
				break;
				case 5:
					if (chk25.value == 'Y')
						fg.ColHidden(CONS_EXEC_YN) = false;
					else
						fg.ColHidden(CONS_EXEC_YN) = true;
				break;
				case 6:
					if (chk26.value == 'Y')
						fg.ColHidden(CONS_DIR_MGT) = false;
					else
						fg.ColHidden(CONS_DIR_MGT) = true;
				break;
				case 7:
					if (chk27.value == 'Y')
						fg.ColHidden(CONS_BUDGET_CODE) = false;
					else
						fg.ColHidden(CONS_BUDGET_CODE) = true;
				break;
				case 8:
					if (chk28.value == 'Y')
						fg.ColHidden(CONS_STAN_CODE) = false;
					else
						fg.ColHidden(CONS_STAN_CODE) = true;
				break;
			}
			

		break;
		case 3:
		break;
		case 4:
			var fg = grdOther.GetGridControl(); 
			switch (n)
			{
			case 1:				
				if (chk41.value == 'Y')
					fg.ColHidden(OTHER_LEVEL) = false;
				else
					fg.ColHidden(OTHER_LEVEL) = true;
			break;
			case 2:				
				if (chk42.value == 'Y')
					fg.ColHidden(OTHER_STANDARD) = false;
				else
					fg.ColHidden(OTHER_STANDARD) = true;
			break;
			case 3:				
				if (chk43.value == 'Y')
				{
					fg.ColHidden(OTHER_ORDER_CODE) = false;
					fg.ColHidden(OTHER_ORDER_NAME) = false;
				}
				else
				{
					fg.ColHidden(OTHER_ORDER_CODE) = true;
					fg.ColHidden(OTHER_ORDER_NAME) = true;
				}
			break;
			}
		break;
	}
}
function onPrint()
{
	switch(idTab.GetCurrentPageNo())
	{
		case 1:
			var path = System.RootURL + "/reports/kp/bp/kpbp922_eq.aspx?p_project_pk=" + txtProjectPk.text
			+ "&p_work="		+ lstWork_Breakdown.value
			+ "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter1.value
			+ "&p_filter="		+ txtFilter1.text + '&p_Chk_WkngUP=' + chkWkngUP.value + '&p_Chk_BCWS=' + chkBCWS.value
            + '&p_WkngUP_Fr=' + txtWkngUP_Fr.text + '&p_WkngUP_To=' + txtWkngUP_To.text + '&p_PriceRange=' + lstPriceRange.value
            + '&p_BCWS_Fr=' + txtBCWS_Fr.text + '&p_BCWS_To=' + txtBCWS_To.text;
			System.OpenTargetPage(path , 'newform');
		break;
		case 2:
			var path = System.RootURL + "/reports/kp/bp/kpbp922_cons.aspx?p_project_pk=" + txtProjectPk.text
			+ "&p_work="		+ lstWork_Breakdown.value
			+ "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter1.value
			+ "&p_filter="		+ txtFilter1.text + '&p_Chk_WkngUP=' + chkWkngUP.value + '&p_Chk_BCWS=' + chkBCWS.value
            + '&p_WkngUP_Fr=' + txtWkngUP_Fr.text + '&p_WkngUP_To=' + txtWkngUP_To.text + '&p_PriceRange=' + lstPriceRange.value
            + '&p_BCWS_Fr=' + txtBCWS_Fr.text + '&p_BCWS_To=' + txtBCWS_To.text;
			System.OpenTargetPage(path , 'newform');
		break;
		case 3:
			var path = System.RootURL + "/reports/kp/bp/kpbp922_cm.aspx?p_project_pk=" + txtProjectPk.text
			+ "&p_work="		+ lstWork_Breakdown.value
			+ "&p_order_work="	+ txtOrderWork_Pk.text;
			System.OpenTargetPage(path , 'newform');
		break;
		case 4:
			var path = System.RootURL + "/reports/kp/bp/kpbp922_other.aspx?p_project_pk=" + txtProjectPk.text
			+ "&p_work="		+ lstWork_Breakdown.value
			+ "&p_order_work="	+ txtOrderWork_Pk.text	+ "&p_lst_filter="	+ lstFilter1.value
			+ "&p_filter="		+ txtFilter1.text + '&p_Chk_WkngUP=' + chkWkngUP.value + '&p_Chk_BCWS=' + chkBCWS.value
            + '&p_WkngUP_Fr=' + txtWkngUP_Fr.text + '&p_WkngUP_To=' + txtWkngUP_To.text + '&p_PriceRange=' + lstPriceRange.value
            + '&p_BCWS_Fr=' + txtBCWS_Fr.text + '&p_BCWS_To=' + txtBCWS_To.text;
			System.OpenTargetPage(path , 'newform');
		break;
	}
}
</script>

<body>
<!--------------------------------------------------------------------->
<gw:data id="dso_version" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="ec111.sp_pro_kpbp2113_1" > 
            <input> 
                <input bind="txtProjectPk" />
            </input>
	       <output>
	            <output bind="lstBudgetItem" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>    
<!--------------------------------------------------------------------->
<gw:data id="dso_grdEQ" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="2" type="grid"  function="EC111.sp_sel_kpbp922_eq"  > 
            <input bind="grdEQ">
                <input bind="txtProjectPk" />
				<input bind="lstWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
				<input bind="lstFilter1" />
				<input bind="txtFilter1" />
                <input bind="chkWkngUP" />
				<input bind="chkBCWS" />
                <input bind="txtWkngUP_Fr" />
				<input bind="txtWkngUP_To" />
				<input bind="lstPriceRange" />
				<input bind="txtBCWS_Fr" />
				<input bind="txtBCWS_To" />
            </input> 
            <output bind="grdEQ" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_grdCONS" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="5" type="grid"  function="EC111.sp_sel_kpbp922_cons"> 
            <input bind="grdCONS">                    
                <input bind="txtProjectPk" />
                <input bind="lstWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
				<input bind="lstFilter2" />
				<input bind="txtFilter2" />
                <input bind="chkWkngUP" />
				<input bind="chkBCWS" />
                <input bind="txtWkngUP_Fr" />
				<input bind="txtWkngUP_To" />
				<input bind="lstPriceRange" />
				<input bind="txtBCWS_Fr" />
				<input bind="txtBCWS_To" />
            </input> 
            <output bind="grdCONS" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_grdCM" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="7" type="grid"  function="EC111.sp_sel_kpbp922_cm" > 
            <input bind="grdCM">                    
                <input bind="txtProjectPk" />
				<input bind="lstWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
            </input> 
            <output bind="grdCM" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dso_grdOther" onreceive="OnReceiveData(this)"> 
    <xml> 
        <dso id="9" type="grid" function="EC111.sp_sel_kpbp922_other" > 
            <input bind="grdOther">                    
                <input bind="txtProjectPk" />
				<input bind="lstWork_Breakdown" />
				<input bind="txtOrderWork_Pk" />
				<input bind="lstFilter4" />
				<input bind="txtFilter4" />
                <input bind="chkWkngUP" />
				<input bind="chkBCWS" />
                <input bind="txtWkngUP_Fr" />
				<input bind="txtWkngUP_To" />
				<input bind="lstPriceRange" />
				<input bind="txtBCWS_Fr" />
				<input bind="txtBCWS_To" />
            </input> 
            <output bind="grdOther" /> 
        </dso> 
    </xml> 
</gw:data>
<table style="background: #BDE9FF;height: 100%; width: 100%" border="0" >
	<tr>
		<td style="width: 100%; background:white">
			<table style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="0">
				<tr style="height: 4%">
					<td style="width: 100%">
						<fieldset style="width:100%;padding:0">
						<table style="width: 100%;">
							<tr style="height:">
								<td align="right" width="11%"><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('project')">Project&nbsp;</a></td>
								<td width="44%">
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="40%">
												<gw:textbox id="txtProject_Cd" readonly="true" styles='width:100%' />
											</td>
											<td width="60%">
												<gw:textbox id="txtProject_Nm" readonly="true" styles='width:100%' />
											</td>
											<td width="">
												<gw:textbox id="txtProjectPk" styles='width:100%;display:none' />
											</td>
											<td>
												<gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProjectPk.text='';" />
											</td>
										</tr>											
									</table>
								 </td>
								<td  align="right" width="10%"><a href="#"  title="Click here to show Work Division"  onClick="OnPopUp('Work_Breakdown')" style="text-decoration:none">W. Div</a></td>
								<td width="35%">
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="36%"><gw:list id="lstWork_Breakdown" styles="width:100%" /></td>
											<td align="right" width="28%">Bdgt Item&nbsp;</td>
											<td width="36%"><gw:list id="lstBudgetItem"  styles='width:100%' onchange="OnChangeBudget()" /></td>
										</tr>
										
									</table>
								 </td>
								<td ><gw:imgbtn id="ibnUpdte" img="search" alt="search" onclick="OnSearch(idTab)" /></td>
                                <td ><gw:imgbtn id="ibnUpdte" img="excel" alt="print report" onclick="onPrint(idTab)" /></td>
							</tr> 
							<tr>                                			
								<td align="right" width="">
									<a title="Click here to show Order Work Division" href="#" style="text-decoration: none"  onClick="OnPopUp('OutsideOrderWork')"">
										Order W. Div&nbsp;</a>
								</td>
								<td width="">
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="40%"><gw:textbox id="txtOrderWork_Cd" readonly="true" styles='width:100%' /></td>
											<td width="60%"><gw:textbox id="txtOrderWork_Nm" readonly="true" styles='width:100%' /></td>	
                                            <td><gw:textbox id="txtOrderWork_Pk" styles='display:none' /></td>										   
											<td><gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtOrderWork_Cd.text='';txtOrderWork_Nm.text='';txtOrderWork_Pk.text='';" /></td>
										</tr>
										
									</table>
								 </td>
								<td style="width: " align="right">Cont. (Y/N)</td>
								<td width="" colspan="">
									<table cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td width="36%"><gw:list id="lstContract_YN" styles='width:100%' /></td>
											<td width="64%" colspan="2" align="right"><gw:checkbox id="chkQty" value="Y" defaultvalue="Y|N"  />Excl. Dtal's Q'ty = "0"</td>
										</tr>
										
									</table>
								</td>
							</tr>
						</table>
						</fieldset>
					</td>
				</tr>
				<tr style="height: 8%">
					<td>
							<fieldset style="width:100%;padding:0">
                                <legend ><img status="expand" id="imgup" src="../../../system/images/up.gif" style="cursor: hand;" onClick="ShowHide() " />&nbsp;Detailed Terms</legend>
								<table width="100%" cellpadding="0" cellspacing="0" border="1" style="border-collapse: collapse" bordercolor="#00CCFF" >
										<tr style="background:#C5EFF1" id="info_1" >
										   <td align="right" width="8%" >Q'ty Check&nbsp;</td>
										   <td width="92%">
												<table cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="" align="right"><gw:checkbox id="chkQty_1" value="N" defaultvalue="Y|N" onchange="OnVisible('Qty_1')" /></td>
														<td align="left">Cont. Q'ty (O), Wkng Q'ty (X)&nbsp;</td>
														<td width="" align="right"><gw:checkbox id="chkQty_2" value="N" defaultvalue="Y|N" onchange="OnVisible('Qty_2')" /></td>
														<td align="left">Cont. Q'ty (X), Wkng Q'ty (O)&nbsp;</td>
														<td width="" align="right"><gw:checkbox id="chkQty_3" value="N" defaultvalue="Y|N" onchange="OnVisible('Qty_3')" /></td>
														<td align="left">Cont. Q'ty &#35; Wkng Q'ty&nbsp;</td>
													</tr>
													
												</table>
										   </td>
										</tr>  
										<tr style="background:#C5EFF1"  id="info_2" >
										   <td align="right" width="" >U/P Comparison&nbsp;</td>
										   <td width="">
												<table cellpadding="0" cellspacing="0" width="100%" border="1" style="border-collapse: collapse" bordercolor="#00CCFF">
													<tr>
														<td align="center" width="20%" rowspan="2">Cont./Working</td>
														<td width="25%">	
															<table cellpadding="0" cellspacing="0" width="100%">
																<tr>
																	<td width="" align="right"><gw:checkbox id="chkCont_more" value="N" defaultvalue="Y|N" onchange="OnVisible('Cont_more')" /></td>
																	<td width="20%"  id="Cmore"><gw:textbox id="txtCont_more" styles='width:100%;text-align:right' /></td>
																	<td align="left" width="" >%Not more Than</td>	
																</tr>
																<tr>
																	<td width="" align="right"><gw:checkbox id="chkCont_less" value="N" defaultvalue="Y|N" onchange="OnVisible('Cont_less')" /></td>
																	<td width="15%"  id="Cless"><gw:textbox id="txtCont_less" styles='width:100%;text-align:right' /></td>
																	<td align="left" width="" >%Not less Than</td>	
																</tr>
															</table>
														</td>
														<td width="10%"><gw:list id="lstUP" styles='width:100%' /></td>
														<td align="center" width="20%">Wkng/Std</td>	
														<td width="25%">	
															<table cellpadding="0" cellspacing="0" width="100%">
																<tr>
																	<td width="" align="right"><gw:checkbox id="chkWkng_more" value="N" defaultvalue="Y|N" onchange="OnVisible('Wkng_more')" /></td>
																	<td width="20%" id='Wmore'><gw:textbox id="txtWkng_more" styles='width:100%;text-align:right' /></td>
																	<td align="left" width="" >%Not more Than</td>	
																</tr>
																<tr>
																	<td width="" align="right"><gw:checkbox id="chkWkng_less" value="N" defaultvalue="Y|N" onchange="OnVisible('Wkng_less')" /></td>
																	<td width="20%" id='Wless'><gw:textbox id="txtWkng_less" styles='width:100%;text-align:right' /></td>
																	<td align="left" width="" >%Not less Than</td>	
																</tr>
															</table>
														</td>
													</tr>
													
												</table>
										   </td>
										</tr> 
										<tr style="background:#C5EFF1"   id="info_3" >
										   <td align="right" width="" >Price Range&nbsp;</td>
										   <td width="">
												<table cellpadding="0" cellspacing="0" width="100%">
													<tr>
														<td width="46%">
															<table cellpadding="0" cellspacing="0" width="100%">
																<tr>	
																	<td align="center" width="20%">Wkng U/P</td>
																	<td width="" align=""><gw:checkbox id="chkWkngUP" value="N" defaultvalue="Y|N" onchange="OnVisible('WkngUP')" /></td>
																	<td width="40%" id='WkngUP_Fr'><gw:textbox id="txtWkngUP_Fr" type="number" format="###,###.##R" styles='width:100%;text-align:right' /></td>
																	<td>~</td>
																	<td width="40%" id='WkngUP_To'><gw:textbox id="txtWkngUP_To" type="number" format="###,###.##R" styles='width:100%;text-align:right' /></td>
																</tr>
															</table>
														</td>
														<td width="2%"></td>
														<td width="10%" align="left"><gw:list id="lstPriceRange" styles='width:100%' /></td>
														<td width="42%" >
															<table cellpadding="0" cellspacing="0" width="100%">
																<tr>	
																	<td align="center" width="20%">BCWS</td>
																	<td width="" align=""><gw:checkbox id="chkBCWS" value="N" defaultvalue="Y|N" onchange="OnVisible('BCWS')" /></td>
																	<td width="40%" id='BCWS_Fr'><gw:textbox id="txtBCWS_Fr" type="number" format="###,###.##R" styles='width:100%;text-align:right' /></td>
																	<td>~</td>
																	<td width="40%" id='BCWS_To'><gw:textbox id="txtBCWS_To" type="number" format="###,###.##R" styles='width:100%;text-align:right' /></td>
																</tr>
															</table>
														</td>
														<td></td>
														<td></td>
													</tr>
													
												</table>
										   </td>
										</tr>  
                                        <tr style="background:#C5EFF1"  id="info_4" >
                                                <td width="" align="right" colspan="2">
                                                			<table cellpadding="0" cellspacing="0" width="100%">
																<tr>
                                                                			<td width="10%" ><gw:radio id="rdo" value="2" > <span value="2">korean?</span>  </gw:radio ></td>
                                                                			<td width="" align="right"><gw:checkbox id="chkD_more" value="N" defaultvalue="Y|N" onchange="OnVisible('Design_more')" /></td>
                                                                            <td width="10%"  id="Dmore"><gw:textbox id="txtD_more" styles='width:100%;text-align:right' /></td>
                                                                            <td align="left" width="20%" >%Not more Than</td>	
                                                                            <td width="" align="right"><gw:checkbox id="chkD_less" value="N" defaultvalue="Y|N" onchange="OnVisible('Design_less')" /></td>
                                                                            <td width="10%"  id="Dless"><gw:textbox id="txtD_less" styles='width:100%;text-align:right' /></td>
                                                                            <td align="left" width="20%" >%Not less Than</td>	
                                                                            <td width="20%" ></td>
                                                                </tr>
                                                            </table>
                                                 </td>
                                                
                                        </tr>
								</table>
							</fieldset >
					</td>
				</tr>
                
				<tr style="height: 88%">
					<td colspan="7">
						<gw:tab id="idTab"  onpageactivate="OnShow() ">
							<table cellpadding="1" cellspacing="1" style="width: 100%; height: 100%; overflow: scroll"	name="Design" id="Tab1">
                            			<tr style="height: 2%;display:none">
                                        			<td>
                                                    			<fieldset  style=""padding:0">
                                                                		<table cellpadding="0" cellspacing="0">
                                                                        			<tr >
                                                                                                <td style="width: 10%" align="right">Select Column</td>
                                                                                                <td style="width: 20%"><gw:list id="lstColumn" styles="width:100%;" /></td>
                                                                                                <td style="width: 5%" align=""></td>
                                                                                                <td style="width: 15%" align="left"><gw:list id="lstFilter" styles="width: 100%" /></td>
                                                                                                <td style="width: 5%" align=""></td>
                                                                                                <td width="20%"><gw:textbox id="txtFilter" styles="width: 100%" /></td>
                                                                                                <td style="width: 5%" align="right">Total</td>
                                                                                                <td style="width: 20%" ><gw:list id="lstTotal" styles="width: 100%" /></td>
                                                                                                <td ><gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="" /></td>
                                                                                    </tr>
                                                                        </table>
                                                                </fieldset>
                                                    </td>
                                        </tr>
                                        <tr style="height:98%">
                                        			<td  width="30%" valign="top">
														<table border="1" style="width:100%;height:100%" cellpadding="0" cellspacing="0" bordercolor="#00CCFF" style="border-collapse: collapse">
														
															<tr height="100%" valign="top">
																<td  valign="top" width="100%"><gw:tree  id="idTree" style="width:100%;height:100%;overflow:scroll" onclicknode="OnClick()" ></gw:tree></td>
															</tr>
														</table>
													</td>
													<!--header="0.Level|1.FBS Code|2.Deliver.|3.Unit|4.Dir. Mgt|5.Outsr|6.Code|7.Name|8.Order Status|9.A. Rslt Rcpt Y/N"-->
                                        			<td colspan="" width="70%" >
                                                    				<gw:grid id="Grid_Design" 
                                                                    header="Level|FBS Code|Deliver.|Unit|Dir. Mgt|Outsr|Code|Name|Order Status|A. Rslt Rcpt Y/N"
                                                                    format="0|0|0|0|0|0|0|0|0|0" 
                                                                    aligns="0|0|0|0|0|0|0|0|0|0"
                                                                    defaults="|||||||||" 
                                                                   editcol="0|0|0|0|0|0|0|0|0|0" 
                                                                    widths="1500|1500|2000|1500|2000|2000|1500|2000|1500|1500"
                                                                    styles="width:100%; height:100%" 
                                                                    sorting="T" 
                                                                    oncelldblclick="" />
                                                    </td>
                                        </tr>
							</table>
							<table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%; overflow: scroll"	name="Equipment" id="Tab2"  >
								<tr style="height: 1%">
									<td>
                                    			 <fieldset style="padding:0">
								                        <table cellpadding="0" cellspacing="0" width=100%>
                                                        		<tr style="">
                                                                				<td colspan="6">
                                                                                			<table cellpadding="0" cellspacing="0" width="100%">
                                                                                            			<tr>
                                                                                                        					<td  align="center"  style="width:10%"><gw:checkbox id="chk1" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk2" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Standard</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk3" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Weight</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk6" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" />Order W. Div</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk7" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" />Exec Y/N</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk8" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" />Budget Code</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk9" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(9)" />Standard PBS</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk10" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(10)" />Dlvr. Terms</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk11" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(11)" />Dlvr.(Y/N)</td>
                                                                                                                            <td  align="center"  style="width:10%"><gw:checkbox id="chk12" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(12)" />Cont. Dtals</td>
                                                                                                        </tr>
                                                                                            </table>
                                                                                </td>
                                                                </tr>								
								                                <tr>
								                                                <td style="width: 20%" align="left"><gw:list id="lstFilter1" styles="width: 100%" /></td>
								                                               <td width="2%"></td> 
									                                            <td width="20%"><gw:textbox id="txtFilter1" styles="width: 100%" /></td>
									                                            <td style="width: 8%" align="right">Total&nbsp;</td>
									                                            <td style="width: 50%" ><gw:list id="lstTotal_1" styles="width: 100%" /></td>
									                                            <td style="display:none" ><gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="OnSearch(idTab)" /></td>
								                                </tr>
								                        </table>
								                </fieldset>
                                    </td>
								</tr>
								<tr style="height: 99%">
                                <!--header="_0.PK|_1.LEVEL_PK|2.Level|3.Item No|4.Name|5.Standard|6.Weight|7.UOM|8.Unit|9.Qty|10.Unit Cost|11.Amount|_12.Order_PK|13.Order Code|14.Order Name|15.Execution (Yes/No)|_16._Budget_PK|17.Budget Code|18.Standard PBS|19.Delivery Term|20.Order Status|21.A. Rslt Rcpt (Y/N)|_22.PROJECT_PK|_23.tecps_undertakectrtbasc_pk|_24.undertakeseq|_25.budgetmst_pk|_26.booking_amt|_27.seq_num" -->
									<td colspan="9" style="width: 100%">
										<gw:grid id="grdEQ" header="_0.PK|_1.LEVEL_PK|2.Level|3.Item No|4.Name|5.Standard|6.Weight|7.UOM|8.Unit|9.Qty
										|10.Unit Cost|11.Amount|_12.Order_PK|13.Order Code|14.Order Name|15.Execution (Yes/No)|_16._Budget_PK|17.Budget Code|18.Standard PBS|19.Delivery Term|20.Order Status
										|21.A. Rslt Rcpt (Y/N)|_22.PROJECT_PK|_23.tecps_undertakectrtbasc_pk|_24.undertakeseq|_25.budgetmst_pk|_26.booking_amt|_27.seq|_28.num" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="||||||||||||||||||||||||||||"
										editcol="0|0|0|0|0|1|1|1|1|1|1|0|1|0|0|1|0|1|1|1|1|1|1|1|0|0|0|0|0" 
										widths="1000|1000|1000|1200|2000|1000|1000|1500|1000|1000|1000|1200|1000|1000|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0|0|0" 
										styles="width:100%; height:100%" 
										sorting="T" debug="false"
										/>
									</td>
								</tr>
							</table>
						   
							<table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%" name="Construction" style="overflow: scroll" id="Tab3">
								<tr style="height: 1%">
									<td>
                                    			 <fieldset style="padding:0">
								                        <table cellpadding="0" cellspacing="0" width="100%">
                                                        		<tr style="">
                                                                				<td colspan="6">
                                                                                			<table cellpadding="0" cellspacing="0">
                                                                                            			<tr>
                                                                                                        					<td  align="center"  style="width:10%"><gw:checkbox id="chk21" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
									                                                                                        <td  align="center"  style="width:10%"><gw:checkbox id="chk22" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Std</td>
									                                                                                        <td colspan="" align="center"  style="width:10%"><gw:checkbox id="chk23" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Raw Mtrl/Labor/Exp</td>
									                                                                                        <td  align="center"   style="width:10%"><gw:checkbox id="chk24" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(4)" />Order W.</td>
									                                                                                        <td  align="center"   style="width:10%"><gw:checkbox id="chk25" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(5)" />Exec Y/N</td>
									                                                                                        <td colspan="" align="center"  style="width:10%"><gw:checkbox id="chk26" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(6)" />Dir. Mgt Outsrc.</td>
									                                                                                        <td  align="center"   style="width:10%"><gw:checkbox id="chk27" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(7)" />Bdgt Code</td>
									                                                                                        <td  align="center"   style="width:10%"><gw:checkbox id="chk28" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(8)" />Std Code</td>
                                                                                                        </tr>
                                                                                            </table>
                                                                                </td>
                                                                </tr>								
								                                <tr>
								                                                <td style="width: 20%" align="left"><gw:list id="lstFilter2" styles="width: 100%" /></td>
								                                               <td width="2%"></td> 
									                                            <td width="20%"><gw:textbox id="txtFilter2" styles="width: 100%" /></td>
									                                            <td style="width: 8%" align="right">Total&nbsp;</td>
									                                            <td style="width: 50%" ><gw:list id="lstTotal_2" styles="width: 100%" /></td>
									                                            <td style="display:none"><gw:imgbtn id="btnSearchs" img="search" alt="Search" onclick="OnSearch(1)" /></td>
								                                </tr>
								                        </table>
								                </fieldset>
                                    </td>
								</tr>
								<tr style="height: 99%">
									<td colspan="9" style="width: 100%">
										<gw:grid id="grdCONS" 
										header="_0.PK|_1.LEVL_PK|2.Level|Code|3.Name|4.Standard|5.Unit|6.Currency|7.Qty|_8.|9.Raw Mtrl. Cost U/P|10.Labor Cost U/P|11.Exp. U/P|12. Unit Price|13.Amount|_14.Order_PK|15.Order Code|16.Order Name|17.Exec. (Y/N)|18.Dir. Mgt Outsrc.|_19.Budget_PK|20.Budget Code|21.Standard Code|22.Calc. Basic|23.Order Status|24.A. Rslt Rcpt Y/N|_25.PROJECT_PK|_26.tecps_undertakectrtbasc_pk|_27.undertakeseq|_28.budgetmst_pk|_29.BOOKING_AMT|_30.SEQ|_31.NUM" 
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="|||||||||||||||||||||||||||||||" 
										editcol="0|0|0|0|1|1|1|1|1|1|1|1|0|0|1|0|0|1|1|1|0|1|1|1|1|1|1|0|0|0|0|0"
										widths="1200|2000|1000|2000|1000|1000|1000|1000|1200|2000|1500|1000|1000|1000|1000|1000|1500|1000|1000|1000|2000|0|0|0|0|0|0|0|0|0|0|0|0"
										styles="width:100%; height:100%" sorting="T" debug="false"
										/>
									</td>
								</tr>
							</table>
							<table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%" name="CM, Sprv" style="overflow: scroll" id="Tab4">
								
								<tr style="height: 100%">
									<td colspan="4" style="width: 100%">
										<gw:grid id="grdCM" header="_0.PK|1.No.|2.Description|_3.LEVEL_PK|4.Name|5.UOM|6.Quantity|7.Ccy|8.MM|9.Unit Cost|10.Amount|11.Ccy|12.MM|13.U/P|14.Amount|15.Sum|_16.OUTSIT_PK|17.Code|18.Name|19.Order Status|20.A. Rslt Rcpt (Y/N)|_21.PROJECT_PK|_22.tecps_undertakectrtbasc_pk|_23.undertakeseq|_24.budgetmst_pk|_25.BOOKING_AMT|_26.SEQ|_27.NUM"
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										defaults="||||||||||||||||||||||||||"
										editcol="0|0|1|0|0|0|0|1|1|1|0|1|1|1|0|0|1|0|0|1|1|1|1|0|0|0|0"
										widths="1000|1100|2000|1000|2000|1000|1000|1000|1500|1500|1500|1000|1500|1500|1500|2000|1000|1000|2000|1000|1000|1000|1000|0|0|0|0"
										styles="width:100%; height:100%" sorting="T" 
										debug="false"/>
									</td>
								</tr>
							</table>
							<table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%" name="Other Service" id="Table5"align="top" style="overflow: scroll">
								<td>
                                    <fieldset>
										<table>
											<tr>												
												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk41" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(1)" />Level Code</td>
												
												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk42" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(2)" />Std</td>

												<td  align="center" nowrap=" align="center" nowrap" style="width:1%"><gw:checkbox id="chk43" value="Y" defaultvalue="Y|N" onchange="OnCheckCol(3)" />Order W. Div</td>
												
												<td style="width: 20%" ></td>
												<td style="width: 15%" align="left">
													<gw:list id="lstFilter4" styles="width: 100%"  onchange="OnChangeFilter(4)" />
												</td>
												<td colspan="3" width="18%"><gw:textbox id="txtFilter4" styles="width: 100%" /></td>
												<td  style="width: 5%" align="right">Total</td>
												<td colspan="3" style="width: 25%" ><gw:list id="lstTotal4" styles="width: 100%" /></td>
												<td style="width: 1%;display:none">				
													<gw:imgbtn id="btnSearchs3" img="search" alt="Search" onclick="OnSearch('OTHER')" />
												</td>
											</tr>	
										</table>
                                    </fieldset>
									</td>
								<tr style="height: 99%">
									<td colspan="4" style="width: 100%">
										<gw:grid id="grdOther" header="_0.PK|_1.LEVEL_PK|2.Level|3.Other Srvc Fld|4.Name|5.Standard
										|6.Unit|7.CCY|8.Q'ty|9.U/P|10.Amount|_11.ORDER_PK|12.Code|13.Name|14.Order Status|15.A. Rslt Rcpt (Y/N)
										|_16.PROJECT_PK|_17.tecps_undertakectrtbasc_pk|_18.undertakeseq|_19.budgetmst_pk|_20.booking_amt|_21.seq|_22.NUM"  
										format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
										defaults="||||||||||||||||||||||" 
									    editcol="1|1|1|1|1|1|1|1|1|1|0|0|0|0|1|1|1|1|0|0|0|0|0"
										widths="1000|1000|1000|1500|2000|1500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0|0|0|0|0|0|0"
										styles="width:100%; height:100%" 
										sorting="T" 
										debug="false"/>
									</td>
								</tr>
							</table>
						</gw:tab>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
    <!----------------------------------------------------------------------------------------->
  
    <!----------------------------------------------------------------------------------------->
</body>
</html>