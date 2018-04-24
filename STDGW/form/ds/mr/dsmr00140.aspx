<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Inspection Research Metal</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>
function BodyInit()
{
	System.Translate(document);  // Translate to language session    
	txtUser_PK.text = "<%=session("USER_PK")%>";
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>";
	data = "<%=ESysLib.SetListDataFUNC("SELECT LG_F_LOGISTIC_CODE('LGIN0210') FROM DUAL" )%>||Select ALL";
	lstWHType.SetDataText(data);
	lstWHType.value = '';

	data = "<%=ESysLib.SetListDataSQL("select pk, wh_id || ' * ' || wh_name from TLG_in_warehouse where del_if = 0 and use_yn='Y' order by wh_id")%>";
	lstWH.SetDataText( data + "||");
	lstWH.value = '';  

	MergeHeaderGrid();
	MergeHeaderGrid_plating();
	MergeHeaderGrid_barel();
}
function OnSearch()
{
	
	if (tab.GetCurrentPageNo() == "0") 
	{
		data_dsmr00140_coating.Call("SELECT");
	}
	else if (tab.GetCurrentPageNo() == "1") 
	{
		data_dsmr00140_plating.Call("SELECT");
	}
	else if (tab.GetCurrentPageNo() == "2") 
	{
		data_dsmr00140_barel.Call("SELECT");
	}

}
function OnDataReceive(obj)
{
	if(obj.id=='data_dsmr00140_coating')
	{
		MergeHeaderGrid();
		if(grdDetail.rows >2)
		{
			grdDetail.Subtotal( 0, 2, -1, '7!8!10!12!14!16!18!20!22!24!26!28!30!32!34!36!38!40!42!44!46!48!50!52!54!56');
			
			var total = Number(grdDetail.GetGridData(grdDetail.rows -1 ,7).replace(/,/g, ''));
			var qty_1 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,8).replace(/,/g, ''));
			var qty_2 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,10).replace(/,/g, ''));
			var qty_3 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,12).replace(/,/g, ''));
			var qty_4 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,14).replace(/,/g, ''));
			var qty_5 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,16).replace(/,/g, ''));
			var qty_6 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,18).replace(/,/g, ''));
			var qty_7 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,20).replace(/,/g, ''));
			var qty_8 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,22).replace(/,/g, ''));
			var qty_9 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,24).replace(/,/g, ''));
			var qty_10 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,26).replace(/,/g, ''));
			var qty_11 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,28).replace(/,/g, ''));
			var qty_12 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,30).replace(/,/g, ''));
			var qty_13 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,32).replace(/,/g, ''));
			var qty_14 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,34).replace(/,/g, ''));
			var qty_15 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,36).replace(/,/g, ''));
			var qty_16 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,38).replace(/,/g, ''));
			var qty_17 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,40).replace(/,/g, ''));
			var qty_18 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,42).replace(/,/g, ''));
			var qty_19 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,44).replace(/,/g, ''));
			var qty_20 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,46).replace(/,/g, ''));
			var qty_21 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,48).replace(/,/g, ''));
			var qty_22 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,50).replace(/,/g, ''));
			var qty_23 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,52).replace(/,/g, ''));
			var qty_24 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,54).replace(/,/g, ''));
			var qty_25 = Number(grdDetail.GetGridData(grdDetail.rows -1 ,56).replace(/,/g, ''));
			var to_per1 = qty_1 / total * 100 ;
			var to_per2 = qty_2 / total * 100 ;
			var to_per3 = qty_3 / total * 100 ;
			var to_per4 = qty_4 / total * 100 ;
			var to_per5 = qty_5 / total * 100 ;
			var to_per6 = qty_6 / total * 100 ;
			var to_per7 = qty_7 / total * 100 ;
			var to_per8 = qty_8 / total * 100 ;
			var to_per9 = qty_9 / total * 100 ;
			var to_per10 = qty_10 / total * 100 ;
			var to_per11 = qty_11 / total * 100 ;
			var to_per12 = qty_12 / total * 100 ;
			var to_per13 = qty_13 / total * 100 ;
			var to_per14 = qty_14 / total * 100 ;
			var to_per15 = qty_15 / total * 100 ;
			var to_per16 = qty_16 / total * 100 ;
			var to_per17 = qty_17 / total * 100 ;
			var to_per18 = qty_18 / total * 100 ;
			var to_per19 = qty_19 / total * 100 ;
			var to_per20 = qty_20 / total * 100 ;
			var to_per21 = qty_21 / total * 100 ;
			var to_per22 = qty_22 / total * 100 ;
			var to_per23 = qty_23 / total * 100 ;
			var to_per24 = qty_24 / total * 100 ;
			var to_per25 = qty_25 / total * 100 ;
			
			grdDetail.SetGridText(grdDetail.rows -1,9,to_per1);
			grdDetail.SetGridText(grdDetail.rows -1,11,to_per2);
			grdDetail.SetGridText(grdDetail.rows -1,13,to_per3);
			grdDetail.SetGridText(grdDetail.rows -1,15,to_per4);
			grdDetail.SetGridText(grdDetail.rows -1,17,to_per5);
			grdDetail.SetGridText(grdDetail.rows -1,19,to_per6);
			grdDetail.SetGridText(grdDetail.rows -1,21,to_per7);
			grdDetail.SetGridText(grdDetail.rows -1,23,to_per8);
			grdDetail.SetGridText(grdDetail.rows -1,25,to_per9);
			grdDetail.SetGridText(grdDetail.rows -1,27,to_per10);
			grdDetail.SetGridText(grdDetail.rows -1,29,to_per11);
			grdDetail.SetGridText(grdDetail.rows -1,31,to_per12);
			grdDetail.SetGridText(grdDetail.rows -1,33,to_per13);
			grdDetail.SetGridText(grdDetail.rows -1,35,to_per14);
			grdDetail.SetGridText(grdDetail.rows -1,37,to_per15);
			grdDetail.SetGridText(grdDetail.rows -1,39,to_per16);
			grdDetail.SetGridText(grdDetail.rows -1,41,to_per17);
			grdDetail.SetGridText(grdDetail.rows -1,43,to_per18);
			grdDetail.SetGridText(grdDetail.rows -1,45,to_per19);
			grdDetail.SetGridText(grdDetail.rows -1,47,to_per20);
			grdDetail.SetGridText(grdDetail.rows -1,49,to_per21);
			grdDetail.SetGridText(grdDetail.rows -1,51,to_per22);
			grdDetail.SetGridText(grdDetail.rows -1,53,to_per23);
			grdDetail.SetGridText(grdDetail.rows -1,55,to_per24);
			grdDetail.SetGridText(grdDetail.rows -1,57,to_per25);
		}	
	}
	else if (obj.id=='data_dsmr00140_plating')
	{
		MergeHeaderGrid_plating();
		if(grdDetail_plating.rows >2)
		{
			grdDetail_plating.Subtotal( 0, 2, -1, '7!8!10!12!14!16!18!20!22!24!26!28!30!32!34!36!38!40!42!44!46!48');
		}	
		var total = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,7).replace(/,/g, ''));
		var qty_1 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,8).replace(/,/g, ''));
		var qty_2 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,10).replace(/,/g, ''));
		var qty_3 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,12).replace(/,/g, ''));
		var qty_4 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,14).replace(/,/g, ''));
		var qty_5 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,16).replace(/,/g, ''));
		var qty_6 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,18).replace(/,/g, ''));
		var qty_7 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,20).replace(/,/g, ''));
		var qty_8 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,22).replace(/,/g, ''));
		var qty_9 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,24).replace(/,/g, ''));
		var qty_10 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,26).replace(/,/g, ''));
		var qty_11 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,28).replace(/,/g, ''));
		var qty_12 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,30).replace(/,/g, ''));
		var qty_13 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,32).replace(/,/g, ''));
		var qty_14 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,34).replace(/,/g, ''));
		var qty_15 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,36).replace(/,/g, ''));
		var qty_16 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,38).replace(/,/g, ''));
		var qty_17 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,40).replace(/,/g, ''));
		var qty_18 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,42).replace(/,/g, ''));
		var qty_19 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,44).replace(/,/g, ''));
		var qty_20 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,46).replace(/,/g, ''));
		var qty_21 = Number(grdDetail_plating.GetGridData(grdDetail_plating.rows -1 ,48).replace(/,/g, ''));
		
		var to_per1 = qty_1 / total * 100 ;
		var to_per2 = qty_2 / total * 100 ;
		var to_per3 = qty_3 / total * 100 ;
		var to_per4 = qty_4 / total * 100 ;
		var to_per5 = qty_5 / total * 100 ;
		var to_per6 = qty_6 / total * 100 ;
		var to_per7 = qty_7 / total * 100 ;
		var to_per8 = qty_8 / total * 100 ;
		var to_per9 = qty_9 / total * 100 ;
		var to_per10 = qty_10 / total * 100 ;
		var to_per11 = qty_11 / total * 100 ;
		var to_per12 = qty_12 / total * 100 ;
		var to_per13 = qty_13 / total * 100 ;
		var to_per14 = qty_14 / total * 100 ;
		var to_per15 = qty_15 / total * 100 ;
		var to_per16 = qty_16 / total * 100 ;
		var to_per17 = qty_17 / total * 100 ;
		var to_per18 = qty_18 / total * 100 ;
		var to_per19 = qty_19 / total * 100 ;
		var to_per20 = qty_20 / total * 100 ;
		var to_per21 = qty_21 / total * 100 ;

		
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,9,to_per1);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,11,to_per2);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,13,to_per3);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,15,to_per4);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,17,to_per5);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,19,to_per6);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,21,to_per7);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,23,to_per8);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,25,to_per9);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,27,to_per10);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,29,to_per11);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,31,to_per12);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,33,to_per13);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,35,to_per14);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,37,to_per15);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,39,to_per16);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,41,to_per17);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,43,to_per18);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,45,to_per19);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,47,to_per20);
		grdDetail_plating.SetGridText(grdDetail_plating.rows -1,49,to_per21);
	
		
	}
	else if (obj.id=='data_dsmr00140_barel')
	{
		MergeHeaderGrid_barel();
		if(grdDetail_barel.rows >2)
		{
			grdDetail_barel.Subtotal( 0, 2, -1, '7!8!10!12!14!16!18!20!22!24!26!28!30!32!34!36!38!40!42!44');
		}	
		
		var total = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,7).replace(/,/g, ''));
		var qty_1 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,8).replace(/,/g, ''));
		var qty_2 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,10).replace(/,/g, ''));
		var qty_3 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,12).replace(/,/g, ''));
		var qty_4 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,14).replace(/,/g, ''));
		var qty_5 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,16).replace(/,/g, ''));
		var qty_6 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,18).replace(/,/g, ''));
		var qty_7 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,20).replace(/,/g, ''));
		var qty_8 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,22).replace(/,/g, ''));
		var qty_9 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,24).replace(/,/g, ''));
		var qty_10 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,26).replace(/,/g, ''));
		var qty_11 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,28).replace(/,/g, ''));
		var qty_12 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,30).replace(/,/g, ''));
		var qty_13 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,32).replace(/,/g, ''));
		var qty_14 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,34).replace(/,/g, ''));
		var qty_15 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,36).replace(/,/g, ''));
		var qty_16 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,38).replace(/,/g, ''));
		var qty_17 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,40).replace(/,/g, ''));
		var qty_18 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,42).replace(/,/g, ''));
		var qty_19 = Number(grdDetail_barel.GetGridData(grdDetail_barel.rows -1 ,44).replace(/,/g, ''));
		
		
		var to_per1 = qty_1 / total * 100 ;
		var to_per2 = qty_2 / total * 100 ;
		var to_per3 = qty_3 / total * 100 ;
		var to_per4 = qty_4 / total * 100 ;
		var to_per5 = qty_5 / total * 100 ;
		var to_per6 = qty_6 / total * 100 ;
		var to_per7 = qty_7 / total * 100 ;
		var to_per8 = qty_8 / total * 100 ;
		var to_per9 = qty_9 / total * 100 ;
		var to_per10 = qty_10 / total * 100 ;
		var to_per11 = qty_11 / total * 100 ;
		var to_per12 = qty_12 / total * 100 ;
		var to_per13 = qty_13 / total * 100 ;
		var to_per14 = qty_14 / total * 100 ;
		var to_per15 = qty_15 / total * 100 ;
		var to_per16 = qty_16 / total * 100 ;
		var to_per17 = qty_17 / total * 100 ;
		var to_per18 = qty_18 / total * 100 ;
		var to_per19 = qty_19 / total * 100 ;


		
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,9,to_per1);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,11,to_per2);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,13,to_per3);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,15,to_per4);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,17,to_per5);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,19,to_per6);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,21,to_per7);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,23,to_per8);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,25,to_per9);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,27,to_per10);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,29,to_per11);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,31,to_per12);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,33,to_per13);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,35,to_per14);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,37,to_per15);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,39,to_per16);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,41,to_per17);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,43,to_per18);
		grdDetail_barel.SetGridText(grdDetail_barel.rows -1,45,to_per19);

	}
}

function MergeHeaderGrid()
{
	var fg = grdDetail.GetGridControl();
     if(fg.Rows < 2)
		{
		   grdDetail.AddRow();     
		}    
		
        fg.FixedRows = 2;
        fg.MergeCells =5;
		fg.MergeRow(0) = true;
		
		fg.MergeCol(0)		= true; 
		fg.Cell(0,0,0,1)    = "No";
		fg.MergeCol(1)		= true; 
		fg.Cell(0,0,1,1)    = "Date";
		
		fg.MergeCol(2)		= true; 
		fg.Cell(0,0,2,1)    = "Shift";
		
		fg.MergeCol(3)		= true; 
		fg.Cell(0,0,3,1)    = "Item Code";
		
		fg.MergeCol(4)		= true; 
		fg.Cell(0,0,4,1)    = "Item Name";
		
		fg.MergeCol(5)		= true; 
		fg.Cell(0,0,5,1)    = "Element";
		
		fg.MergeCol(6)		= true; 
		fg.Cell(0,0,6,1)    = "Color";
		
		fg.MergeCol(7)		= true; 
		fg.Cell(0,0,7,1)    = "Q.ty inspected";
		
		fg.Cell(0,0,8,0,9)    = "OK Products";
		fg.Cell(0,1,8,1)	= "Q.ty";
		fg.Cell(0,1,9,1)	= "%";
		
		fg.Cell(0,0,10,0,11)    = "Phế/ Waste";
		fg.Cell(0,1,10,1)	= "Q.ty";
		fg.Cell(0,1,11,1)	= "%";
		
		fg.Cell(0,0,12,0,13)    = "Sửa Rework";
		fg.Cell(0,1,12,1)	= "Q.ty";
		fg.Cell(0,1,13,1)	= "%";
		
		fg.Cell(0,0,14,0,15)    = "Dộp/ Bubble";
		fg.Cell(0,1,14,1)	= "Q.ty";
		fg.Cell(0,1,15,1)	= "%";
		
		fg.Cell(0,0,16,0,17)    = "Sức mẻ, lẹm/ Dent";
		fg.Cell(0,1,16,1)	= "Q.ty";
		fg.Cell(0,1,17,1)	= "%";
		
		fg.Cell(0,0,18,0,19)    = "Phế đuôi, chốt/ Deformed Tail, pin";
		fg.Cell(0,1,18,1)	= "Q.ty";
		fg.Cell(0,1,19,1)	= "%";
		
		fg.Cell(0,0,20,0,21)    = "Mờ logo, nhám/ logo Logo blear, logo rough";
		fg.Cell(0,1,20,1)	= "Q.ty";
		fg.Cell(0,1,21,1)	= "%";
		
		fg.Cell(0,0,22,0,23)    = "Dày xi/ Plating Thicker";
		fg.Cell(0,1,22,1)	= "Q.ty";
		fg.Cell(0,1,23,1)	= "%";
		
		fg.Cell(0,0,24,0,25)    = "Phế khác/ Others waste";
		fg.Cell(0,1,24,1)	= "Q.ty";
		fg.Cell(0,1,25,1)	= "%";
		
		fg.Cell(0,0,26,0,27)    = "Dính keo/ Coating particle";
		fg.Cell(0,1,26,1)	= "Q.ty";
		fg.Cell(0,1,27,1)	= "%";
		
		fg.Cell(0,0,28,0,29)    = "Đọng keo/ Coating drops";
		fg.Cell(0,1,28,1)	= "Q.ty";
		fg.Cell(0,1,29,1)	= "%";
		
		fg.Cell(0,0,30,0,31)    = "Khác màu/ Different color";
		fg.Cell(0,1,30,1)	= "Q.ty";
		fg.Cell(0,1,31,1)	= "%";
		
		fg.Cell(0,0,32,0,33)    = "Dơ bụi/ Coating dust";
		fg.Cell(0,1,32,1)	= "Q.ty";
		fg.Cell(0,1,33,1)	= "%";
		
		fg.Cell(0,0,34,0,35)    = "Dấu móc keo/ Hanger mark";
		fg.Cell(0,1,34,1)	= "Q.ty";
		fg.Cell(0,1,35,1)	= "%";
		
		fg.Cell(0,0,36,0,37)    = "Oxi hóa/ Oxidation";
		fg.Cell(0,1,36,1)	= "Q.ty";
		fg.Cell(0,1,37,1)	= "%";
		
		fg.Cell(0,0,38,0,39)    = "Nhám keo/ Coating rough";
		fg.Cell(0,1,38,1)	= "Q.ty";
		fg.Cell(0,1,39,1)	= "%";
		
		fg.Cell(0,0,40,0,41)    = "Bung keo/ Burst coating";
		fg.Cell(0,1,40,1)	= "Q.ty";
		fg.Cell(0,1,41,1)	= "%";
		
		fg.Cell(0,0,42,0,43)    = "Bung xi/ Burst nickel";
		fg.Cell(0,1,42,1)	= "Q.ty";
		fg.Cell(0,1,43,1)	= "%";
		
		fg.Cell(0,0,44,0,45)    = "Lòi đồng, lòi Niken";
		fg.Cell(0,1,44,1)	= "Q.ty";
		fg.Cell(0,1,45,1)	= "%";
		
		fg.Cell(0,0,46,0,47)    = "Lệch chốt/ Pin slant";
		fg.Cell(0,1,46,1)	= "Q.ty";
		fg.Cell(0,1,47,1)	= "%";
		
		fg.Cell(0,0,48,0,49)    = "Trầy keo/ Coating Scratch";
		fg.Cell(0,1,48,1)	= "Q.ty";
		fg.Cell(0,1,49,1)	= "%";
		
		fg.Cell(0,0,50,0,51)    = "Nghẹt chốt/ Congestion pin";
		fg.Cell(0,1,50,1)	= "Q.ty";
		fg.Cell(0,1,51,1)	= "%";
		
		fg.Cell(0,0,52,0,53)    = "Nhám xi, dơ xi Plating rough, dirty";
		fg.Cell(0,1,52,1)	= "Q.ty";
		fg.Cell(0,1,53,1)	= "%";
		
		fg.Cell(0,0,54,0,55)    = "Chấm trắng/ White dot";
		fg.Cell(0,1,54,1)	= "Q.ty";
		fg.Cell(0,1,55,1)	= "%";
		
		fg.Cell(0,0,56,0,57)    = "Lỗi khác/ Others";
		fg.Cell(0,1,56,1)	= "Q.ty";
		fg.Cell(0,1,57,1)	= "%";
		
		fg.MergeCol(58)		= true; 
		fg.Cell(0,0,58,1)    = "Remark";
		
		fg.MergeCol(59)		= true; 
		fg.Cell(0,0,59,1)    = "YJ Plan";
		
		fg.MergeCol(60)		= true; 
		fg.Cell(0,0,60,1)    = "Slip No";
		
		fg.MergeCol(61)		= true; 
		fg.Cell(0,0,61,1)    = "WH Name";
		
		
}
function MergeHeaderGrid_plating()
{
	var fg = grdDetail_plating.GetGridControl();
	

	fg.RowHeight(0) = 600;

     if(fg.Rows < 2)
		{
		   grdDetail_plating.AddRow();     
		}    
		
        fg.FixedRows = 2;
        fg.MergeCells =5;
		fg.MergeRow(0) = true;
		
		fg.MergeCol(0)		= true; 
		fg.Cell(0,0,0,1)    = "No";
		fg.MergeCol(1)		= true; 
		fg.Cell(0,0,1,1)    = "Date";
		
		fg.MergeCol(2)		= true; 
		fg.Cell(0,0,2,1)    = "Shift";
		
		fg.MergeCol(3)		= true; 
		fg.Cell(0,0,3,1)    = "Item Code";
		
		fg.MergeCol(4)		= true; 
		fg.Cell(0,0,4,1)    = "Item Name";
		
		fg.MergeCol(5)		= true; 
		fg.Cell(0,0,5,1)    = "Element";
		
		fg.MergeCol(6)		= true; 
		fg.Cell(0,0,6,1)    = "Color";
		
		fg.MergeCol(7)		= true; 
		fg.Cell(0,0,7,1)    = "Q.ty inspected";
		
		fg.Cell(0,0,8,0,9)    = "OK Products";
		fg.Cell(0,1,8,1)	= "Q.ty";
		fg.Cell(0,1,9,1)	= "%";
		
		fg.Cell(0,0,10,0,11)    = "Phế"+"\n"+"Waste";
		fg.Cell(0,1,10,1)	= "Q.ty";
		fg.Cell(0,1,11,1)	= "%";
		
		fg.Cell(0,0,12,0,13)    = "Sửa"+"\n"+"Rework";
		fg.Cell(0,1,12,1)	= "Q.ty";
		fg.Cell(0,1,13,1)	= "%";
		
		fg.Cell(0,0,14,0,15)    = "Dộp"+"\n"+"Bubble";
		fg.Cell(0,1,14,1)	= "Q.ty";
		fg.Cell(0,1,15,1)	= "%";
		
		fg.Cell(0,0,16,0,17)    = "Bavia"+"\n"+"Burr";
		fg.Cell(0,1,16,1)	= "Q.ty";
		fg.Cell(0,1,17,1)	= "%";
		
		fg.Cell(0,0,18,0,19)    = "Sứt mẻ, lẹm"+"\n"+"Dent";
		fg.Cell(0,1,18,1)	= "Q.ty";
		fg.Cell(0,1,19,1)	= "%";
		
		fg.Cell(0,0,20,0,21)    = "Axít ăn mòn"+"\n"+"Acid corrosion";
		fg.Cell(0,1,20,1)	= "Q.ty";
		fg.Cell(0,1,21,1)	= "%";
		
		fg.Cell(0,0,22,0,23)    = "Mờ logo, nhám logo"+"\n"+"Logo blear, logo rough";
		fg.Cell(0,1,22,1)	= "Q.ty";
		fg.Cell(0,1,23,1)	= "%";
		
		fg.Cell(0,0,24,0,25)    = "Dày xi"+"\n"+"Plating thicker";
		fg.Cell(0,1,24,1)	= "Q.ty";
		fg.Cell(0,1,25,1)	= "%";
		
		fg.Cell(0,0,26,0,27)    = "Phế khác"+"\n"+"Other waste";
		fg.Cell(0,1,26,1)	= "Q.ty";
		fg.Cell(0,1,27,1)	= "%";
		
		fg.Cell(0,0,28,0,29)    = "Dơ xi"+"\n"+"Plating dirty";
		fg.Cell(0,1,28,1)	= "Q.ty";
		fg.Cell(0,1,29,1)	= "%";
		
		fg.Cell(0,0,30,0,31)    = "Mờ xi"+"\n"+"Opaque";
		fg.Cell(0,1,30,1)	= "Q.ty";
		fg.Cell(0,1,31,1)	= "%";
		
		fg.Cell(0,0,32,0,33)    = "Oxi hóa"+"\n"+"Oxidation";
		fg.Cell(0,1,32,1)	= "Q.ty";
		fg.Cell(0,1,33,1)	= "%";
		
		fg.Cell(0,0,34,0,35)    = "Dấu móc đen"+"\n"+"Black hanger";
		fg.Cell(0,1,34,1)	= "Q.ty";
		fg.Cell(0,1,35,1)	= "%";
		
		fg.Cell(0,0,36,0,37)    = "Lòi đồng"+"\n"+"Can see Copper inside";
		fg.Cell(0,1,36,1)	= "Q.ty";
		fg.Cell(0,1,37,1)	= "%";
		
		fg.Cell(0,0,38,0,39)    = "Lòi Nickel"+"\n"+"Can see Nickel inside";
		fg.Cell(0,1,38,1)	= "Q.ty";
		fg.Cell(0,1,39,1)	= "%";
		
		fg.Cell(0,0,40,0,41)    = "Khác màu"+"\n"+"Different color";
		fg.Cell(0,1,40,1)	= "Q.ty";
		fg.Cell(0,1,41,1)	= "%";
		
		fg.Cell(0,0,42,0,43)    = "Trầy xi"+"\n"+"Plating scratch";
		fg.Cell(0,1,42,1)	= "Q.ty";
		fg.Cell(0,1,43,1)	= "%";
		
		fg.Cell(0,0,44,0,45)    = "Dơ chữ"+"\n"+"Letter dirty";
		fg.Cell(0,1,44,1)	= "Q.ty";
		fg.Cell(0,1,45,1)	= "%";
		
		fg.Cell(0,0,46,0,47)    = "Nhám xi"+"\n"+"Plating rough";
		fg.Cell(0,1,46,1)	= "Q.ty";
		fg.Cell(0,1,47,1)	= "%";
		
		fg.Cell(0,0,48,0,49)    = "Lỗi khác"+"\n"+"Others";
		fg.Cell(0,1,48,1)	= "Q.ty";
		fg.Cell(0,1,49,1)	= "%";
		
		/*fg.Cell(0,0,46,0,47)    = "Lệch chốt/ Pin slant";
		fg.Cell(0,1,46,1)	= "Q.ty";
		fg.Cell(0,1,47,1)	= "%";
		
		fg.Cell(0,0,48,0,49)    = "Trầy keo/ Coating Scratch";
		fg.Cell(0,1,48,1)	= "Q.ty";
		fg.Cell(0,1,49,1)	= "%";
		
		fg.Cell(0,0,50,0,51)    = "Nghẹt chốt/ Congestion pin";
		fg.Cell(0,1,50,1)	= "Q.ty";
		fg.Cell(0,1,51,1)	= "%";
		
		fg.Cell(0,0,52,0,53)    = "Nhám xi, dơ xi Plating rough, dirty";
		fg.Cell(0,1,52,1)	= "Q.ty";
		fg.Cell(0,1,53,1)	= "%";
		
		fg.Cell(0,0,54,0,55)    = "Chấm trắng/ White dot";
		fg.Cell(0,1,54,1)	= "Q.ty";
		fg.Cell(0,1,55,1)	= "%";
		
		fg.Cell(0,0,56,0,57)    = "Lỗi khác/ Others";
		fg.Cell(0,1,56,1)	= "Q.ty";
		fg.Cell(0,1,57,1)	= "%";*/
		
		fg.MergeCol(50)		= true; 
		fg.Cell(0,0,50,1)    = "Remark";
		
		fg.MergeCol(51)		= true; 
		fg.Cell(0,0,51,1)    = "YJ Plan";
		
		fg.MergeCol(52)		= true; 
		fg.Cell(0,0,52,1)    = "Slip No";
		
		fg.MergeCol(53)		= true; 
		fg.Cell(0,0,53,1)    = "WH Name";
		
		
		
}
function MergeHeaderGrid_barel()
{
	var fg = grdDetail_barel.GetGridControl();
     if(fg.Rows < 2)
		{
		   grdDetail_barel.AddRow();     
		}    
		
        fg.FixedRows = 2;
        fg.MergeCells =5;
		fg.MergeRow(0) = true;
		
		fg.MergeCol(0)		= true; 
		fg.Cell(0,0,0,1)    = "No";
		fg.MergeCol(1)		= true; 
		fg.Cell(0,0,1,1)    = "Date";
		
		fg.MergeCol(2)		= true; 
		fg.Cell(0,0,2,1)    = "Shift";
		
		fg.MergeCol(3)		= true; 
		fg.Cell(0,0,3,1)    = "Item Code";
		
		fg.MergeCol(4)		= true; 
		fg.Cell(0,0,4,1)    = "Item Name";
		
		fg.MergeCol(5)		= true; 
		fg.Cell(0,0,5,1)    = "Element";
		
		fg.MergeCol(6)		= true; 
		fg.Cell(0,0,6,1)    = "Color";
		
		fg.MergeCol(7)		= true; 
		fg.Cell(0,0,7,1)    = "Q.ty inspected";
		
		fg.Cell(0,0,8,0,9)    = "OK Products";
		fg.Cell(0,1,8,1)	= "Q.ty";
		fg.Cell(0,1,9,1)	= "%";
		
		fg.Cell(0,0,10,0,11)    = "Phế/ Waste";
		fg.Cell(0,1,10,1)	= "Q.ty";
		fg.Cell(0,1,11,1)	= "%";
		
		fg.Cell(0,0,12,0,13)    = "Sửa Rework";
		fg.Cell(0,1,12,1)	= "Q.ty";
		fg.Cell(0,1,13,1)	= "%";
		
		fg.Cell(0,0,14,0,15)    = "Lủng (Pinhole)";
		fg.Cell(0,1,14,1)	= "Q.ty";
		fg.Cell(0,1,15,1)	= "%";
		
		fg.Cell(0,0,16,0,17)    = "Mài lẹm /(Over grinding)";
		fg.Cell(0,1,16,1)	= "Q.ty";
		fg.Cell(0,1,17,1)	= "%";
		
		fg.Cell(0,0,18,0,19)    = "Dập lẹm /(Over punching)";
		fg.Cell(0,1,18,1)	= "Q.ty";
		fg.Cell(0,1,19,1)	= "%";
		
		fg.Cell(0,0,20,0,21)    = "Vảy cá /(Fish Sccale)";
		fg.Cell(0,1,20,1)	= "Q.ty";
		fg.Cell(0,1,21,1)	= "%";
		
		fg.Cell(0,0,22,0,23)    = "Phế khác/(Waste Other)";
		fg.Cell(0,1,22,1)	= "Q.ty";
		fg.Cell(0,1,23,1)	= "%";
		
		fg.Cell(0,0,24,0,25)    = "Lệch móc/(Hook slant)";
		fg.Cell(0,1,24,1)	= "Q.ty";
		fg.Cell(0,1,25,1)	= "%";
		
		fg.Cell(0,0,26,0,27)    = "Dập chưa tới /(Less punching)";
		fg.Cell(0,1,26,1)	= "Q.ty";
		fg.Cell(0,1,27,1)	= "%";
		
		fg.Cell(0,0,28,0,29)    = "Mài chưa tới /(Less grinding)";
		fg.Cell(0,1,28,1)	= "Q.ty";
		fg.Cell(0,1,29,1)	= "%";
		
		fg.Cell(0,0,30,0,31)    = "Lệch khuôn/(Mold deviated)";
		fg.Cell(0,1,30,1)	= "Q.ty";
		fg.Cell(0,1,31,1)	= "%";
		
		fg.Cell(0,0,32,0,33)    = "Va chạm bề mặt/(Surface bumpy) ";
		fg.Cell(0,1,32,1)	= "Q.ty";
		fg.Cell(0,1,33,1)	= "%";
		
		fg.Cell(0,0,34,0,35)    = "Nhám do barrel /(Barrel rough)";
		fg.Cell(0,1,34,1)	= "Q.ty";
		fg.Cell(0,1,35,1)	= "%";
		
		fg.Cell(0,0,36,0,37)    = "Dơ logo, dơ chữ/(Logo dirty, letter dirty)  ";
		fg.Cell(0,1,36,1)	= "Q.ty";
		fg.Cell(0,1,37,1)	= "%";
		
		fg.Cell(0,0,38,0,39)    = "Nghẹt đuôi/(Function) ";
		fg.Cell(0,1,38,1)	= "Q.ty";
		fg.Cell(0,1,39,1)	= "%";
		
		fg.Cell(0,0,40,0,41)    = "Dinh Da (Stone Sticky) ";
		fg.Cell(0,1,40,1)	= "Q.ty";
		fg.Cell(0,1,41,1)	= "%";
		
		fg.Cell(0,0,42,0,43)    = "Bavia /(Burr)";
		fg.Cell(0,1,42,1)	= "Q.ty";
		fg.Cell(0,1,43,1)	= "%";
		
		fg.Cell(0,0,44,0,45)    = "Lỗi khác /(Others)";
		fg.Cell(0,1,44,1)	= "Q.ty";
		fg.Cell(0,1,45,1)	= "%";
		
		
		fg.MergeCol(46)		= true; 
		fg.Cell(0,0,46,1)    = "Remark";
		
		fg.MergeCol(47)		= true; 
		fg.Cell(0,0,47,1)    = "YJ Plan";
		
		fg.MergeCol(48)		= true; 
		fg.Cell(0,0,48,1)    = "Slip No";
		
		fg.MergeCol(49)		= true; 
		fg.Cell(0,0,49,1)    = "WH Name";
		
		
}
function OnPrint()
{
	if (tab.GetCurrentPageNo() == "0") 
	{
		var url =System.RootURL + '/reports/ds/mr/rpt_dsmr00140.aspx?p_dt_frm='+ dtFrom.value + '&p_dt_to='+ dtTo.value + '&p_item='+ txtItem.text + '&p_wh_type='+ lstWHType.value+ '&p_wh_pk='+ lstWH.value+ '&p_yj_plan='+ txtYJPlan.text;
	        window.open(url);
	}
	else if (tab.GetCurrentPageNo() == "1") 
	{
		var url =System.RootURL + '/reports/ds/mr/rpt_dsmr00140_1.aspx?p_dt_frm='+ dtFrom.value + '&p_dt_to='+ dtTo.value + '&p_item='+ txtItem.text + '&p_wh_type='+ lstWHType.value+ '&p_wh_pk='+ lstWH.value+ '&p_yj_plan='+ txtYJPlan.text;
	        window.open(url);
	}
	else if (tab.GetCurrentPageNo() == "2") 
	{
		var url =System.RootURL + '/reports/ds/mr/rpt_dsmr00140_2.aspx?p_dt_frm='+ dtFrom.value + '&p_dt_to='+ dtTo.value + '&p_item='+ txtItem.text + '&p_wh_type='+ lstWHType.value+ '&p_wh_pk='+ lstWH.value+ '&p_yj_plan='+ txtYJPlan.text;
	        window.open(url);
	}
	 

}
</script>
<body>
<!---------------------------------------------------------------->
	<gw:data id="dso_pro_dsmr00140" onreceive="OnDataReceive(this)">
		<xml>
			<dso type="list" procedure="<%=l_user%>lg_pro_dsmr00140" >
				<input>
					<input bind="lstWHType" />
				</input>
				<output>
					<output bind="lstWH" />
				</output>
			</dso>
		</xml>
	</gw:data>
<!--------------------------------------------------------------------->
    <gw:data id="data_dsmr00140_coating" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="lg_sel_dsmr00140_coating"  >
                <input bind="grdDetail" >
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
			        <input bind="txtItem" />
			        <input bind="lstWHType" />
					<input bind="lstWH" />
					<input bind="txtYJPlan" />					
                </input>
                <output bind="grdDetail" />
            </dso>
        </xml>
    </gw:data>
	<!--------------------------------------------------------------------->
    <gw:data id="data_dsmr00140_plating" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="lg_sel_dsmr00140_plating"  >
                <input bind="grdDetail_plating" >
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
			        <input bind="txtItem" />
			        <input bind="lstWHType" />
					<input bind="lstWH" />
					<input bind="txtYJPlan" />					
                </input>
                <output bind="grdDetail_plating" />
            </dso>
        </xml>
    </gw:data>
	<!--------------------------------------------------------------------->
    <gw:data id="data_dsmr00140_barel" onreceive="OnDataReceive(this)">
        <xml> 
            <dso id="1" type="grid"  function="lg_sel_dsmr00140_barel"  >
                <input bind="grdDetail_barel" >
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
			        <input bind="txtItem" />
			        <input bind="lstWHType" />
					<input bind="lstWH" />
					<input bind="txtYJPlan" />					
                </input>
                <output bind="grdDetail_barel" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------->
	<table style="width: 100%; height: 100%">
	 <tr style="height: 1%">
			<td style="width: 5%" align="right">
				Date
			</td>
			<td style="white-space: nowrap; width:15%">
				<gw:datebox id="dtFrom" lang="1" />
				~
				<gw:datebox id="dtTo" lang="1" /> 
			</td>
			
			<td align="right" style="width: 5%; white-space: nowrap">
				W/H Type
			</td>
			<td style="width:15%;white-space: nowrap">
				<gw:list id="lstWHType" styles='width:100%' csstype="mandatory" onchange="dso_pro_dsmr00140.Call('SELECT')"  />
			</td>
			<td align="right" style="width: 5%; white-space: nowrap">
				W/H
			</td>
			<td style="width:15%;white-space: nowrap">
				<gw:list id="lstWH" styles='width:100%' csstype="mandatory" />
			</td>
			<td style="width: 5%" align="right">
				Item 
			</td>
			<td style="width:15%">
				<gw:textbox id="txtItem" styles="width: 100%" onenterkey="OnSearch()" />
			</td>
			<td align="right" style="width: 5%; white-space: nowrap">
				YJ Plan
			</td>
			<td style="width:15%">
				<gw:textbox id="txtYJPlan" styles="width: 100%" onenterkey="OnSearch()" />
			</td>
			<td style="width: 1%">
				<gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
			</td>
			<td width="1%" align='right'>                          
				<gw:button img="excel" text="Print" alt="Print Out Report" onclick="OnPrint()" />
			</td>
	<tr>
	<tr style="height:99%">
		<td colspan="12">
			<gw:tab id="tab"> 
				<table style="width: 100%; height: 100%"name="Coating">
					<tr style="height: 99%" >
						<td colspan="12">
							<gw:grid id='grdDetail' header='_1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62'
								format='0|0|0|0|0|0|0|-0|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|0|0|0|0' 
								aligns='|||||1|1|||||||||||||||||||||||||||||||||||||||||||||||||||||||'
								check='|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||' 
								editcol='|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||' 
								widths='1000|1200|2200|2800|3200|1200|1200|1500|1200|1300|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200'
								sorting='T' styles='width:100%; height:100%' onafteredit="" oncellclick="" />
						</td>
					</tr>	
				</table>  

				<table style="width: 100%; height: 100%"name="Plating">
					<tr style="height: 99%" >
						<td colspan="12">
							<gw:grid id='grdDetail_plating' header='_1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54'
								format='0|0|0|0|0|0|0|-0|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|0|0|0|0' 
								aligns='|||||||||||||||||||||||||||||||||||||||||||||||||||||'					
								widths='1000|1200|2200|2800|3200|1200|1200|1500|1200|1300|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200'
								sorting='T' styles='width:100%; height:100%' onafteredit="" oncellclick="" />
						</td>
					</tr>	
				</table>  

				<table style="width: 100%; height: 100%"name="Barel">
					<tr style="height: 99%" >
						<td colspan="12">
							<gw:grid id='grdDetail_barel' header='_1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50'
								format='0|0|0|0|0|0|0|-0|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|-0|-2|0|0' 
								aligns='||||||||||||||||||||||||||||||||||||||||||||||||'
								widths='1000|1200|2200|2800|3200|1200|1200|1500|1200|1300|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200'
								sorting='T' styles='width:100%; height:100%' onafteredit="" oncellclick="" />
						</td>
					</tr>	
				</table>  
			</gw:tab>	
		</td>
	</tr>
</table>  	

</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />

</html>
