<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>126</title>
</head>
<%ESysLib.SetUser("ec111")%>
<script>
var flag='search';
//------------------------------------------------------------------
function BodyInit()
{
	System.Translate(document);
	BindingDataList(); 
	Merge_grid();
}   
//------------------------------------------------------------------
function BindingDataList()
{
	Grid1.GetGridControl().WordWrap = true;
	Grid1.GetGridControl().RowHeight(0) = 450 ;
	//---6.Integrated Unit Price (Y/N)--------------------
	<%=ESysLib.SetGridColumnComboFormat("Grid1",6,"SELECT   code, b.code_nm  FROM tac_commcode_master a, tac_commcode_detail b  WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'TPS0029' AND a.del_if = 0  AND b.del_if = 0 AND b.use_yn = 'Y' ORDER BY code, b.code_nm")%>;
	//---8.Confirm Y/N--------------------
	//<%=ESysLib.SetGridColumnComboFormat("Grid1",8,"SELECT   code, b.code_nm  FROM tac_commcode_master a, tac_commcode_detail b  WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'TPS0004' AND a.del_if = 0  AND b.del_if = 0 AND b.use_yn = 'Y' ORDER BY code, b.code_nm")%>;
    //-----------Currency
	<%=ESysLib.SetGridColumnComboFormat("Grid2",1,"SELECT CODE, CODE  FROM comm.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK =b.pk and b.id='ACAB0110' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 order by a.DEF_YN desc , ord")%>;
	//-----------Currency
	<%=ESysLib.SetGridColumnComboFormat("Grid2",5,"SELECT CODE, CODE  FROM comm.TCO_ABCODE A, comm.TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK =b.pk and b.id='ACAB0110' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 order by a.DEF_YN desc , ord")%>;
    var fg = Grid1.GetGridControl();
	fg.ColFormat(5) = "#,###,###,###,###,###,###,###,###.##R";
	var fg2 = Grid2.GetGridControl();
	fg2.ColFormat(3) = "#,###,###,###,###";
	if(Grid2.GetGridData(1,1)== "VND" )
	{
		fg2.ColFormat(2) = "#,###,###,###,###,###,###,###,###";
	}else{
		fg2.ColFormat(2) = "#,###,###,###,###,###,###,###,###,###.##R";
	}
    
	var fg3 = Grid3.GetGridControl();
	fg3.ColFormat(3) = "#,###,###,###,###";
	fg3.ColFormat(1) = "#,###,###,###,###,###,###,###,###.##R";
	fg3.ColFormat(2) = "#,###,###,###,###,###,###,###,###.##R";
	fg3.ColFormat(3) = "#,###,###,###,###,###,###,###,###.##R";

	fg3.ColFormat(4) = "#,###,###,###,###,###,###,###,###.##R";
	fg3.ColFormat(5) = "#,###,###,###,###,###,###,###,###.##R";
	fg3.ColFormat(6) = "#,###,###,###,###,###,###,###,###.##R";

	fg3.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##R";
	fg3.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
	fg3.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";
    var fg4 = Grid3.GetGridControl();
	if(Grid2.rows > 1 )
	{
		var l_bookccy = Grid2.GetGridData(1,5);
		var l_trsccy = Grid2.GetGridData(1,1);
		if (l_bookccy=='VND')
		{
			fg3.ColFormat(1) = "#,###,###,###,###,###,###,###,###";
			fg3.ColFormat(2) = "#,###,###,###,###,###,###,###,###";
			fg3.ColFormat(3) = "#,###,###,###,###,###,###,###,###";

			fg3.ColFormat(4) = "#,###,###,###,###,###,###,###,###";
			fg3.ColFormat(5) = "#,###,###,###,###,###,###,###,###";
			fg3.ColFormat(6) = "#,###,###,###,###,###,###,###,###";

			fg3.ColFormat(7) = "#,###,###,###,###,###,###,###,###";
			fg3.ColFormat(8) = "#,###,###,###,###,###,###,###,###";
			fg3.ColFormat(9) = "#,###,###,###,###,###,###,###,###";

		}else{
			fg3.ColFormat(1) = "#,###,###,###,###,###,###,###,###.##R";
			fg3.ColFormat(2) = "#,###,###,###,###,###,###,###,###.##R";
			fg3.ColFormat(3) = "#,###,###,###,###,###,###,###,###.##R";

			fg3.ColFormat(4) = "#,###,###,###,###,###,###,###,###.##R";
			fg3.ColFormat(5) = "#,###,###,###,###,###,###,###,###.##R";
			fg3.ColFormat(6) = "#,###,###,###,###,###,###,###,###.##R";

			fg3.ColFormat(7) = "#,###,###,###,###,###,###,###,###.##R";
			fg3.ColFormat(8) = "#,###,###,###,###,###,###,###,###.##R";
			fg3.ColFormat(9) = "#,###,###,###,###,###,###,###,###.##R";

		}

     }

	
}
//-------------------------------------------------------------------
function OnPopUp(obj)
{
	switch(obj)
	{
		case 'project':
			var path = System.RootURL + '/form/kp/bp/kpbp00060_1.aspx';
			var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
			if ( object != null )
			{
				txproject_Pk.text = object[0];
				txproject_Cd.text = object[1];
				txtxproject_Nm.text = object[2]; 
                OnSearch(0);
			}
		break;
	}
}
//---------------------------------------------------------------------
function OnNew()
{
    if(txproject_Pk.GetData()=="")
	{
		alert('You must choose project first.');
		return false;
	}else{

         if(Grid1.rows  == 1)
		 {
			    Grid1.AddRow();
				Grid1.SetGridText(Grid1.rows-1, 9,txproject_Pk.GetData());
				Grid1.SetGridText(Grid1.rows-1, 1,0);
		 }else{
		        var lcount=0 ;
                for (var i=1; i <Grid1.rows; i++ )
                {
					if(Grid1.GetGridData(i,8)=='N')
						lcount=lcount + 1;
                } 
				if (lcount !=0)
				{
					alert('You must confirm remain version first');
					return;
				}
		      else{
		      if(confirm("Are you sure to increase version ?"))
			  {
				Grid1.AddRow();
				Grid1.SetGridText(Grid1.rows-1, 9,txproject_Pk.GetData());
				var revion_no	= 0;
				if (Grid1.rows-1 == 1)
				{
					revion_no	= 0;
				}else if (Grid1.rows-1 > 1)
				{
					revion_no = 1 + Number(Grid1.GetGridData(Grid1.rows-2,1));
				}
				Grid1.SetGridText(Grid1.rows-1, 1,revion_no);
				Grid1.SetGridText(Grid1.rows-1, 2,Grid1.GetGridData(Grid1.rows-2,2));
				Grid1.SetGridText(Grid1.rows-1, 3,Grid1.GetGridData(Grid1.rows-2,3));
				Grid1.SetGridText(Grid1.rows-1, 4,Grid1.GetGridData(Grid1.rows-2,4));
				Grid1.SetGridText(Grid1.rows-1, 5,Grid1.GetGridData(Grid1.rows-2,5));
				Grid1.SetGridText(Grid1.rows-1, 6,Grid1.GetGridData(Grid1.rows-2,6));
				Grid1.SetGridText(Grid1.rows-1, 7,Grid1.GetGridData(Grid1.rows-2,7));
				Grid1.SetGridText(Grid1.rows-1, 8,"N");
			  }
			  }
          }
     }
}
//---------------------------------------------------------------------    
function OnSearch(idx)
{
	switch(idx)
	{
		case 0:
		 flag='search';
         dso_kpbp00060_1.Call("SELECT");
        break;
		case 1:
		 txt_tps_prjconversion_pk.text = Grid1.GetGridData(Grid1.row,0);
		
		 if(txt_tps_prjconversion_pk.text != "")
		 {
			dso_kpbp00060_2.Call("SELECT");
         }
        break;
		case 2:
		
         dso_kpbp00060_4.Call("SELECT");
        break;
    }
}   
//--------------------------------------------------------------
function Merge_grid()
{
	if (Grid3.rows < 2)
		{
			
			Grid3.AddRow();
		}

	var fg=Grid3.GetGridControl();
    	Grid3.SetCellBold(1,1,1,9,true);
		fg.FixedRows = 2
		fg.MergeCells = 5

		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Category"

		fg.MergeRow(0) = true
		fg.Cell(0, 0, 1, 0, 5) = "Transaction Amount"  
        fg.Cell(0, 1, 1, 1) 	= "CCY"
		fg.Cell(0, 1, 2, 1 ) 	= "Material"
		fg.Cell(0, 1, 3, 1) 	= "Labor"
		fg.Cell(0, 1, 4, 1) 	= "Expenses"
		fg.Cell(0, 1, 5, 1) 	= "Total"

		fg.Cell(0, 0, 6, 0, 9) = "Booking"  
       
		fg.Cell(0, 1, 6, 1 ) 	= "Material "
		fg.Cell(0, 1, 7, 1) 	= "Labor "
		fg.Cell(0, 1, 8, 1) 	= "Expenses"
		fg.Cell(0, 1, 9, 1) 	= "Total"

       
		

}
//-------------------------------------------------------------
function onDelete()
{
	 if(confirm("Do you want to delete selected row ?"))
	 {
		Grid1.DeleteRow();
		Grid1.SetGridText(Grid1.row,10,"");
		dso_kpbp00060_1.Call();
     }
}
//-------------------------------------------------------------
function onSave()
{
    flag='save';
	Grid1.SetGridText(Grid1.row,10,"");
	dso_kpbp00060_1.Call();
}
//======================================================================
function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case "dso_kpbp00060_1":
		   if (Grid2.rows > 1)
		   {
			 // alert();
			  dso_kpbp00060_2.Call();
		   }
		 
		break;
		case "dso_kpbp00060_2":
			OnSearch(2);
		 
		break;
		case "dso_kpbp00060_3":
			Grid2.SetGridText(Grid2.row,3,txtexrate.GetData());
			Caculate_bamt();
			//OnSearch(2);
			   dso_kpbp00060_4.Call("SELECT");
		break;
	    case "dso_kpbp00060_4":
			Merge_grid();
		break;
	}
}
//-------------------------------------------------------------
function getexrate()
{
	txtexrate_dt.text = Grid2.GetGridData(Grid2.row,4);
    lstCompany.text ="<%=Session("COMPANY_PK")%>"; 
    txtccy.text = Grid2.GetGridData(Grid2.row,1);
	dso_kpbp00060_3.Call();
}
//--------------------------------------------------------------
function Caculate_bamt()
{
	var bookccy ='';
	bookccy=Grid2.GetGridData(Grid2.row,5);
	var trsccy ='';
		trsccy = Grid2.GetGridData(Grid2.row,1);
    var bookamt=0;
	var tranamt = Grid2.GetGridData(Grid2.row,2);
	   
	    tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		tranamt = tranamt.replace(',','');
		
	var exrate  =Grid2.GetGridData(Grid2.row,3);
    var book_exrate = Grid2.GetGridData(Grid2.row,7);    
 

	if (bookccy=='VND')
	{
		if (trsccy=='VND')
		{
			bookamt = tranamt;
		}else if (trsccy=='USD'){
			bookamt = tranamt * exrate;
		}else{
			bookamt = (tranamt * exrate) / Number(book_exrate);
		}


	}else{
		if (trsccy=='USD')
		{
			bookamt = Number(tranamt);
		}else if (trsccy=='VND'){
			bookamt = tranamt/ exrate;
		}else{
			bookamt = (tranamt * exrate) / book_exrate;
		}
	}
	
	Grid2.SetGridText(Grid2.row,6,bookamt);

}
//-------------------------------------------------------------
function onConfirm1()
{
	if(confirm("Are you sure to confirm ?"))
	 {
		Grid1.SetGridText(Grid1.row,10,'confirm');
	    dso_kpbp00060_1.Call();
     }
}
//--------------------------------------------------------------
</script>
<body>
<gw:data id="dso_kpbp00060_1" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10"  function="ec111.sp_sel_kpbp00060_1"  procedure="ec111.sp_upd_kpbp00060_1">
                <input bind="Grid1">
                    <input bind="txproject_Pk"/>
                </input>
                <output bind="Grid1"/>
            </dso>
        </xml>
    </gw:data>
<!------------------------------------------------------------------->
<gw:data id="dso_kpbp00060_2" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid"  parameter="0,1,2,3,4,5,6"  function="ec111.sp_sel_kpbp00060_2"  procedure="ec111.sp_upd_kpbp00060_2">
                <input bind="Grid2">
                    <input bind="txt_tps_prjconversion_pk"/>
                </input>
                <output bind="Grid2"/>
            </dso>
        </xml>
    </gw:data>

 <!-------------------------------------------------------------------------------->
 <gw:data id="dso_kpbp00060_3"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="process" parameter="0,1,2"  procedure="ec111.sp_sel_kpbp00060_3"> 
                <input>   
				   <input bind="txtexrate_dt" /> 
                   <input bind="lstCompany" />
				   <input bind="txtccy" /> 
                </input> 
                <output>
                    <output bind="txtexrate" />
			
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------->
<gw:data id="dso_kpbp00060_4" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid"    function="ec111.sp_sel_kpbp00060_4" >
                <input bind="Grid3">
                    <input bind="txt_tps_prjconversion_pk"/>
				    <input bind="txproject_Pk"/>
                </input>
                <output bind="Grid3"/>
            </dso>
        </xml>
    </gw:data>
<!------------------------------------------------------------------->
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0">
	<tr style="height:10%">
	  <td >
		<fieldset> 
		  <table cellpadding="0" cellspacing="2" width="100%" >
			<tr>
			   <td align="left" width="8%" ><a title="Click here to show project" href="#" style="text-decoration:none" onclick="OnPopUp('project');">Project&nbsp;</a></td> 
               <td width="30%"><gw:textbox id="txproject_Cd" readonly="true" styles='width:100%' /></td>
			   <td width="45%"><gw:textbox id="txtxproject_Nm" readonly="true" styles='width:100%' /><gw:textbox id="txproject_Pk" styles='width:100%;display:none' /></td> 
			   <td></td>  
			   <td ><gw:imgbtn id="btjv2" img="reset" alt="Reset"  onclick="txproject_Pk.text='';txproject_Cd.text='';txtxproject_Nm.text='';" /></td>
			   <td align="right" width="5%"></td>
			   <td align="right"><gw:imgbtn id="btInquiry" img="search" alt="Inquiry"  onclick="OnSearch(0)" /></td> 
			   <td align="right"><gw:imgbtn id="btIncreaseversion" img="new" alt="Increase version"  onclick="OnNew()" /></td>
               <td align="right"><gw:imgbtn id="btApply" img="process" alt="Apply exchange rate"  onclick="OnSearch(0)" /></td>
			   <td align="right"><gw:imgbtn id="btConfirm" img="confirm" alt="Confirm"  onclick="onConfirm1()" /></td>
			   <td align="right"><gw:imgbtn id="btSave" img="save" alt="Save"  onclick="onSave()" /></td> 
			   <td align="right"><gw:imgbtn id="btDelete" img="delete" alt="Delete All"  onclick="onDelete()" /></td>
			 </tr>
			</table> 
		</fieldset>
	  </td>  
	</tr>
	<tr >
	    <!--0_pk|1.Reversion No|2.Main Contract Date|3.Starting Date|4.End Date|5.Main Contract Amount|6.Integrated Unit Price (Y/N)|	7.Remark|8.Confirm Y/N|9._project_pk|10._status-->
		<td>
			<gw:grid   
				id="Grid1"  
				header="_pk|Revision No|Main Contract Date|Starting Date|End Date|Main Contract Amount|Integrated Unit Price (Y/N)|Remark|Confirm Y/N|_project_pk|_status"   
				format  ="0|0|4|4|4|0|0|0|0|0|0"  
				aligns  ="0|1|1|1|1|3|1|2|1|0|0"  
				defaults="||||||||||"  
				editcol ="1|1|1|1|1|1|1|1|1|1|0"  
				widths  ="0|1000|1300|1300|1300|1500|1500|2500|1000|0|0"  
				styles="width:100%; height:150"   
				sorting="T"   
				acceptNullDate
				oncellclick="OnSearch(1)"
			 /> 
		</td>
	</tr> 
	<tr >
	    <!--0_pk|1.Trs. Currency|2.Main Contract Amount|3.Ex Rate|4.EX Rate Date|5.Book Currency|6.Booking Amount|7.Exrate book-->
		<td>
			<gw:grid   
				id="Grid2"  
				header="_pk|Trs. Currency|Main Contract Amount|Ex Rate|EX Rate Date|Book Currency|Booking Amount|Exrate book"   
				format  ="0|0|0|0|4|0|0|0"  
				aligns  ="0|1|3|3|1|1|3|3"  
				defaults="0|0|0|1|0|0|0|0"  
				editcol ="1|1|1|1|1|0|1|1"  
				widths  ="1500|2000|3000|1200|1500|3000|1000"  
				styles="width:100%; height:80"   
				sorting="T" 
				acceptNullDate
				onafteredit="getexrate()"
			 /> 
		</td>
	</tr> 
	<tr >
	    <!--0_pk|1.Reversion No|2.Main Contract Date|3.Starting Date|4.End Date|5.Main Contract Amount|6.Integrated Unit Price (Y/N)|	7.Remark|8.Confirm Y/N-->
		<td>
			<gw:grid   
				id="Grid3"  
				header="pk|Reversion No|Main Contract Date|Starting Date|End Date|Main Contract Amount|Integrated Unit Price (Y/N)|Remark|Confirm Y/N|Remark"   
				format  ="0|0|0|00|0|0|0|0|0|0"  
				aligns  ="0|3|3|3|3|3|3|3|3|3"  
				defaults="|||||||||"  
				editcol ="0|0|0|0|0|0|0|0|0|0"  
				widths  ="3000|1500|1500|900|1500|1500|900|1500|1500|900"  
				styles="width:100%; height:200"   
				sorting="T"   
			 /> 
		</td>
	</tr> 
</table>  
 <!--------------------------------------------------------------------------->
    <gw:textbox id="txt_tps_prjconversion_pk" styles='display:none;width:100%' />
    <gw:textbox id="txtexrate_dt" styles='display:none;width:100%' />
	<gw:textbox id="lstCompany" styles='display:none;width:100%' />
	<gw:textbox id="txtccy" styles='display:none;width:100%' />
	<gw:textbox id="txtexrate" styles='display:none;width:100%' />
    <!--------------------------------------------------------------------------->
</body>

</html>
