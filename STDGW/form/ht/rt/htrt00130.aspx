<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Manufacturing Instruction and Record (3. Printing)</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    //left.style.display="none";
    //OnClick('OnToggle');
    BingdingData();
    PartyTypeChange();
    OnSearch('grdSearchI_Food');
}
function BingdingData()
{
        var data,dataMenuFood;
        data = "<%=ESysLib.SetListDataSQL("select pk, grp_cd || ' - ' || grp_nm from comm.tco_itemgrp where del_if = 0 and use_yn='Y' and leaf_yn = 'Y' and (PROD_YN ='Y' or SALE_YN ='Y') order by grp_nm ") %>||Select All";     
        dataMenuFood = "<%=ESysLib.SetListDataSQL("select pk,MENU_ID||' - '|| MENU_NAME from tht_menu where del_if=0") %>||Select All";     
        lstItemFood.SetDataText(dataMenuFood);
        lstItemFood.value=''; 
        lstItemBeverage.SetDataText(data);
        lstItemOther.SetDataText(data);
        lstItemPromotion.SetDataText(data);
        data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PARTY'" )%>||Select All"; 
	    lstPartyType.SetDataText(data);
	    lstPartyTypesearch.SetDataText(data);
	    <%=ESysLib.SetGridColumnComboFormat( "grdSearch" , 3 , "SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='PARTY'") %>; 
	    lstPartyTypesearch.value='';
	    data ="DATA|Morning|Morning|Noon|Noon|Night|Night|Morning-Noon|Morning-Noon|Noon-Night|Noon-Night|Morning-Night|Morning-Night"; 
        lstBeginTime.SetDataText(data);  
        data ="DATA|Save|Save|Comfirm|Comfirm|Close|Close"; 
        lstStatus.SetDataText(data);  
        data ="DATA|USD|USD|VND|VND|EUR|EUR|KRW|KRW"; 
        lstCurrency.SetDataText(data);  
        dtFrom.SetDataText(System.AddDate(dtFrom.GetData(),-7));
        txtCreator.SetReadOnly(true);
        txtSlipNo.SetReadOnly(true);
}
var f_save = false,f_delete = false,f_action=false;;
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearchI_Food' :        
            dso_htrt00060_food.Call("SELECT")
        break;
        case 'grdSearchI_Beverage' :        
            dso_htrt00060_Beverage.Call("SELECT")            
        break;
        case 'grdSearchI_Other' :        
            dso_htrt00060_others.Call("SELECT")                 
        break;
        case 'grdSearchI_Promotions' :        
            dso_htrt00060_promotion.Call("SELECT")               
        break;
        case 'Search' :        
            dso_htrt00060.Call("SELECT")               
        break;
        case 'Master' :
            if ( grdSearch.row > 0 )
            {
//                if(grdSearch.col==3)
//                {
//                    return grdSearch.row=-1;
//                }
                txtMasterPK.text = grdSearch.GetGridData( event.row, 0);                
            }
            else
            {
                txtMasterPK.text = '' ;
            }
            f_action=false;
            dso_htrt00060_mst.Call("SELECT");
        break;
    }
}
function OnchangeTab()
{
       if(idTab_Child.GetCurrentPageNo()==0 && grdItemFood.rows-1 < 1)
       {
            //grdItemFood.ClearData();
            grdItemBeverage.ClearData();
            grdItemOther.ClearData();
            grdItemPromotion.ClearData();
            OnSearch('grdSearchI_Food');
       } 
       if(idTab_Child.GetCurrentPageNo()==1 && grdItemBeverage.rows-1 < 1)
       {
            //grdItemFood.ClearData();
            //grdItemBeverage.ClearData();
            grdItemOther.ClearData();
            grdItemPromotion.ClearData();
            OnSearch('grdSearchI_Beverage');
       }
       if(idTab_Child.GetCurrentPageNo()==2 && grdItemOther.rows-1 < 1)               
       {
            //grdItemFood.ClearData();
            grdItemBeverage.ClearData();
            //grdItemOther.ClearData();
            grdItemPromotion.ClearData();
            OnSearch('grdSearchI_Other');
       }
       if(idTab_Child.GetCurrentPageNo()==3 && grdItemPromotion.rows-1 < 1)
       {
            //grdItemFood.ClearData();
            grdItemBeverage.ClearData();
            grdItemOther.ClearData();
            //grdItemPromotion.ClearData();
            OnSearch('grdSearchI_Promotions');
       }         
}
function OnClick(obj)
{
	switch(obj)
	{
		case 'OnToggle':
			var left  = document.all("left");    
			var right = document.all("right");   
			var imgArrow = document.all("imgArrow");

			if(imgArrow.status == "expand")
			{
				left.style.display="none";       
				imgArrow.status = "collapse";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/next_orange.gif";
			}
			else
			{
				left.style.display="";
				imgArrow.status = "expand";
				right.style.width="50%";
				imgArrow.src = "../../../system/images/prev_orange.gif";
			}
		break;
	}	
}
function ValidateData()
{
    if(lstPartyType.value =='PARTY-B')
    {
        if(txtCustomerID.text=='' || txtCustomerName.text=='')
        {
            alert("You must input Customs."); 
            return false;
        }
        if(txtContact.text=='')
        {
            alert("You must input contact.");
            return false;
        }
        return true;
     }
     else
     {
        if(txtCustomerID.text=='' || txtCustomerName.text=='')
        {
            alert("You must input Customs.");     
            return false;
        }
        if(txtMobile.text=='')
        {
            alert("You must input number mobile.");    
            return false;  
        }
        if(txtTelephone.text=='')
        {
            alert("You must input number telephone.");    
            return false;  
        }
        if(txtContact.text=='')
        {
            alert("You must input contact.");
            return false;
        }
        return true;
     }
}
function GetPK()
{
        if (grdFood.rows > 1)
			{
				for (row = 1; row < grdFood.rows; row++)
				{
				    if(grdFood.GetGridData( row, 1) == '')
				    {
					    grdFood.SetGridText(row, 1, txtMasterPK.text);
					}
				}

			}
			if (grdBeverage.rows > 1)
			{
				for (row = 1; row < grdBeverage.rows; row++)
				{
				    if(grdBeverage.GetGridData( row, 1) == '')
				    {
					    grdBeverage.SetGridText(row, 1, txtMasterPK.text);  
					}
				}
			}
			if (grdF_B_Other.rows > 1)
			{
				for (row = 1; row < grdF_B_Other.rows; row++)
				{
				    if(grdF_B_Other.GetGridData( row, 1) == '')
				    {
					    grdF_B_Other.SetGridText(row, 1, txtMasterPK.text);
					}
				}
			}
			if (grdPromotion.rows > 1)
			{
				for (row = 1; row < grdPromotion.rows; row++)
				{
				    if(grdPromotion.GetGridData( row, 1) == '')
				    {
					    grdPromotion.SetGridText(row, 1, txtMasterPK.text);
					}
				}
			}
}
function OnDataReceive(obj)
{
    switch (obj.id)
    {
       case 'dso_htrt00060_food' :  
            if(txtMasterPK.text !="" && lstPartyType.value !='PARTY-B')   
            {      
                dso_htrt00060_2_FOOD.Call("SELECT");  
            }
            else
            {
               grdFood.ClearData();  
            } 
        break;
        case 'dso_htrt00060_Beverage' : 
            if(txtMasterPK.text !="" && lstPartyType.value !='PARTY-B')
            {       
                dso_htrt00060_3_BEVER.Call("SELECT");  
            }
            else
            {
                grdBeverage.ClearData(); 
            }           
        break;
        case 'dso_htrt00060_others' :
            if(txtMasterPK.text !="" && lstPartyType.value !='PARTY-B')
            {        
                dso_htrt00060_4_OTHER.Call("SELECT");
            }
            else
            {
                grdF_B_Other.ClearData(); 
            }                     
        break;
        case 'dso_htrt00060_promotion' :
            if(txtMasterPK.text !="" && lstPartyType.value !='PARTY-B')
            {        
                dso_htrt00060_5_PROMOTION.Call("SELECT"); 
            } 
            else
            {
                grdPromotion.ClearData(); 
            }              
        break;//ukhk
        case "dso_htrt00060_mst" :
                if(f_save == true || f_delete == true)
                {
				    if(f_save == true)
				    {
				        GetPK();
				    }
				    else
				    {
				       f_delete = false;
				       grdFood.ClearData(); 
				       grdBeverage.ClearData(); 
				       grdF_B_Other.ClearData(); 
				       grdPromotion.ClearData();
				       OnSearch('Search');
				    }
				}
				else
				{
				   
				   if(f_action == false)
				   {
				       PartyTypeChange();
				       GetPK();
				       idTab_Child.SetPage(0);
				       dso_htrt00060_2_FOOD.Call("SELECT"); 
				   }
				}
        break;
        case "dso_htrt00060_2_FOOD" :
              f_action=true;
              SumFoods();
              //dso_htrt00060_mst.Call();
        break;
        case "dso_htrt00060_3_BEVER" :
              f_action=true;  
              SumBeverages(); 
              //dso_htrt00060_mst.Call();
        break;
        case "dso_htrt00060_4_OTHER" :
              f_action=true;  
              SumServiceOthers(); 
              //dso_htrt00060_mst.Call();  
        break;
     }
}
function OnSelectRoom1(obj)
{
    var dupli = false;
    switch (obj.id)
    {
        case 'ibtnSelectFood' :
              for(i = 1; i < grdItemFood.rows; i++)
	            {
		            if (grdItemFood.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemFood.GetGridData(i, 6) > 0)
			            {
				            var room_type = grdItemFood.GetGridData(i, 2);
            				
				            for (row = 1; row < grdFood.rows; row++)
				            {
					            if (grdFood.GetGridData(row, 4) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
					            //alert("hehe");
					            grdFood.AddRow();
            					grdFood.SetGridText(grdFood.rows-1, 1, txtMasterPK.text);
					            grdFood.SetGridText(grdFood.rows-1, 2, grdItemFood.GetGridData(i, 0));
					            grdFood.SetGridText(grdFood.rows-1, 3, grdItemFood.GetGridData(i, 1));
					            grdFood.SetGridText(grdFood.rows-1, 4, grdItemFood.GetGridData(i, 2));
					            grdFood.SetGridText(grdFood.rows-1, 5, grdItemFood.GetGridData(i, 3));
					            grdFood.SetGridText(grdFood.rows-1, 6, grdItemFood.GetGridData(i, 4));
					            grdFood.SetGridText(grdFood.rows-1, 7, grdItemFood.GetGridData(i, 5));
					            grdFood.SetGridText(grdFood.rows-1, 8, grdItemFood.GetGridData(i, 6));
					            grdFood.SetGridText(grdFood.rows-1, 9, grdItemFood.GetGridData(i, 7));
					            grdFood.SetGridText(grdFood.rows-1, 10, grdItemFood.GetGridData(i, 8));
					            grdFood.SetGridText(grdFood.rows-1, 11, grdItemFood.GetGridData(i, 9));
				            }
			            }
		            }
	            }      
        break;
        case 'ibtnSelectFood1' :
              for(i = 1; i < grdItemBeverage.rows; i++)
	            {
		            if (grdItemBeverage.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemBeverage.GetGridData(i, 5) > 0)
			            {
				            var room_type = grdItemBeverage.GetGridData(i, 1);
            				
				            for (row = 1; row < grdBeverage.rows; row++)
				            {
					            if (grdBeverage.GetGridData(row, 3) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
					            grdBeverage.AddRow();
            					
					            grdBeverage.SetGridText(grdBeverage.rows-1, 1, txtMasterPK.text);
					            grdBeverage.SetGridText(grdBeverage.rows-1, 2, grdItemBeverage.GetGridData(i, 0));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 3, grdItemBeverage.GetGridData(i, 1));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 4, grdItemBeverage.GetGridData(i, 2));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 5, grdItemBeverage.GetGridData(i, 3));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 6, grdItemBeverage.GetGridData(i, 4));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 7, grdItemBeverage.GetGridData(i, 5));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 8, grdItemBeverage.GetGridData(i, 6));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 9, grdItemBeverage.GetGridData(i, 7));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 10, grdItemBeverage.GetGridData(i, 8));
				            }
			            }
		            }
	            }       
        break;
        case 'ibtnSelectFood2' : 
              for(i = 1; i < grdItemOther.rows; i++)
	            {
		            if (grdItemOther.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemOther.GetGridData(i, 5) > 0)
			            {
				            var room_type = grdItemOther.GetGridData(i, 1);
            				
				            for (row = 1; row < grdF_B_Other.rows; row++)
				            {
					            if (grdF_B_Other.GetGridData(row, 3) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
					            grdF_B_Other.AddRow();
            					
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 1, txtMasterPK.text);
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 2, grdItemOther.GetGridData(i, 0));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 3, grdItemOther.GetGridData(i, 1));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 4, grdItemOther.GetGridData(i, 2));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 5, grdItemOther.GetGridData(i, 3));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 6, grdItemOther.GetGridData(i, 4));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 7, grdItemOther.GetGridData(i, 5));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 8, grdItemOther.GetGridData(i, 6));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 9, grdItemOther.GetGridData(i, 7));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 10, grdItemOther.GetGridData(i, 8));
				            }
			            }
		            }
	            }       
        break;
        case 'ibtnSelectFood3' :   
              for(i = 1; i < grdItemPromotion.rows; i++)
	            {
		            if (grdItemPromotion.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemPromotion.GetGridData(i, 5) > 0)
			            {
				            var room_type = grdItemPromotion.GetGridData(i, 1);
            				
				            for (row = 1; row < grdPromotion.rows; row++)
				            {
					            if (grdPromotion.GetGridData(row, 3) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
					            grdPromotion.AddRow();
            					
					            grdPromotion.SetGridText(grdPromotion.rows-1, 1, txtMasterPK.text);
					            grdPromotion.SetGridText(grdPromotion.rows-1, 2, grdItemPromotion.GetGridData(i, 0));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 3, grdItemPromotion.GetGridData(i, 1));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 4, grdItemPromotion.GetGridData(i, 2));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 5, grdItemPromotion.GetGridData(i, 3));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 6, grdItemPromotion.GetGridData(i, 4));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 7, grdItemPromotion.GetGridData(i, 5));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 8, grdItemPromotion.GetGridData(i, 6));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 9, grdItemPromotion.GetGridData(i, 7));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 10, grdItemPromotion.GetGridData(i, 8));
				            }
			            }
		            }
	            }       
        break;
     }
}
function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{
   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, 0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}
function OnSelectRoom(obj)
{
    var dupli = false;
    switch (obj.id)
    {
        case 'grdItemFood' :
              for(i = 1; i < grdItemFood.rows; i++)
	            {
		            if (grdItemFood.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemFood.GetGridData(i, 6) > 0)
			            {
				            var room_type = grdItemFood.GetGridData(i, 2);
				            var col_val = obj.GetGridData(event.row, 0 );
            				
				            for (row = 1; row < grdFood.rows; row++)
				            {
					            if (grdFood.GetGridData(row, 4) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
					            //alert("hehe");
					            SetRowBackGroundColor(obj,col_val,0x0000FF);
					            grdFood.AddRow();
            					grdFood.SetGridText(grdFood.rows-1, 1, txtMasterPK.text);
					            grdFood.SetGridText(grdFood.rows-1, 2, grdItemFood.GetGridData(i, 0));
					            grdFood.SetGridText(grdFood.rows-1, 3, grdItemFood.GetGridData(i, 1));
					            grdFood.SetGridText(grdFood.rows-1, 4, grdItemFood.GetGridData(i, 2));
					            grdFood.SetGridText(grdFood.rows-1, 5, grdItemFood.GetGridData(i, 3));
					            grdFood.SetGridText(grdFood.rows-1, 6, grdItemFood.GetGridData(i, 4));
					            grdFood.SetGridText(grdFood.rows-1, 7, grdItemFood.GetGridData(i, 5));
					            grdFood.SetGridText(grdFood.rows-1, 8, grdItemFood.GetGridData(i, 6));
					            grdFood.SetGridText(grdFood.rows-1, 9, grdItemFood.GetGridData(i, 7));
					            grdFood.SetGridText(grdFood.rows-1, 10, grdItemFood.GetGridData(i, 8));
					            grdFood.SetGridText(grdFood.rows-1, 11, grdItemFood.GetGridData(i, 9));
				            }
			            }
		            }
	            }      
        break;
        case "grdItemBeverage" :
              for(i = 1; i < grdItemBeverage.rows; i++)
	            {
		            if (grdItemBeverage.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemBeverage.GetGridData(i, 5) > 0)
			            {
				            var room_type = grdItemBeverage.GetGridData(i, 1);
            				var col_val = obj.GetGridData(event.row, 0 );
				            for (row = 1; row < grdBeverage.rows; row++)
				            {
					            if (grdBeverage.GetGridData(row, 3) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
				                SetRowBackGroundColor(obj,col_val,0x0000FF);
					            grdBeverage.AddRow();            					
					            grdBeverage.SetGridText(grdBeverage.rows-1, 1, txtMasterPK.text);
					            grdBeverage.SetGridText(grdBeverage.rows-1, 2, grdItemBeverage.GetGridData(i, 0));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 3, grdItemBeverage.GetGridData(i, 1));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 4, grdItemBeverage.GetGridData(i, 2));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 5, grdItemBeverage.GetGridData(i, 3));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 6, grdItemBeverage.GetGridData(i, 4));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 7, grdItemBeverage.GetGridData(i, 5));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 8, grdItemBeverage.GetGridData(i, 6));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 9, grdItemBeverage.GetGridData(i, 7));
					            grdBeverage.SetGridText(grdBeverage.rows-1, 10, grdItemBeverage.GetGridData(i, 8));
				            }
			            }
		            }
	            }       
        break;
        case "grdItemOther" : 
              for(i = 1; i < grdItemOther.rows; i++)
	            {
		            if (grdItemOther.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemOther.GetGridData(i, 5) > 0)
			            {
				            var room_type = grdItemOther.GetGridData(i, 1);
            				var col_val = obj.GetGridData(event.row, 0 );
				            for (row = 1; row < grdF_B_Other.rows; row++)
				            {
					            if (grdF_B_Other.GetGridData(row, 3) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
				                SetRowBackGroundColor(obj,col_val,0x0000FF);
					            grdF_B_Other.AddRow();             					
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 1, txtMasterPK.text);
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 2, grdItemOther.GetGridData(i, 0));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 3, grdItemOther.GetGridData(i, 1));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 4, grdItemOther.GetGridData(i, 2));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 5, grdItemOther.GetGridData(i, 3));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 6, grdItemOther.GetGridData(i, 4));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 7, grdItemOther.GetGridData(i, 5));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 8, grdItemOther.GetGridData(i, 6));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 9, grdItemOther.GetGridData(i, 7));
					            grdF_B_Other.SetGridText(grdF_B_Other.rows-1, 10, grdItemOther.GetGridData(i, 8));
				            }
			            }
		            }
	            }       
        break;
        case "grdItemPromotion" :   
              for(i = 1; i < grdItemPromotion.rows; i++)
	            {
		            if (grdItemPromotion.GetGridControl().isSelected(i) == true)
		            {
			            if (grdItemPromotion.GetGridData(i, 5) > 0)
			            {
				            var room_type = grdItemPromotion.GetGridData(i, 1);
            				var col_val = obj.GetGridData(event.row, 0 );
				            for (row = 1; row < grdPromotion.rows; row++)
				            {
					            if (grdPromotion.GetGridData(row, 3) == room_type)
						            dupli = true;
				            }

				            if (dupli == false)
				            {
					            SetRowBackGroundColor(obj,col_val,0x0000FF);
					            grdPromotion.AddRow();            					
					            grdPromotion.SetGridText(grdPromotion.rows-1, 1, txtMasterPK.text);
					            grdPromotion.SetGridText(grdPromotion.rows-1, 2, grdItemPromotion.GetGridData(i, 0));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 3, grdItemPromotion.GetGridData(i, 1));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 4, grdItemPromotion.GetGridData(i, 2));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 5, grdItemPromotion.GetGridData(i, 3));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 6, grdItemPromotion.GetGridData(i, 4));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 7, grdItemPromotion.GetGridData(i, 5));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 8, grdItemPromotion.GetGridData(i, 6));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 9, grdItemPromotion.GetGridData(i, 7));
					            grdPromotion.SetGridText(grdPromotion.rows-1, 10, grdItemPromotion.GetGridData(i, 8));
				            }
			            }
		            }
	            }       
        break;
     }
}
function OnRemoveRoom(obj)
{
    switch (obj.id)
    {
        case "ibtnRemoveFood" :
              for(row = grdFood.rows-1; row > 0 ; row--)
	            {
		            if (grdFood.GetGridControl().isSelected(row) == true)
		            {
			            if (grdFood.GetGridData(row, 0) == '')
				            grdFood.RemoveRowAt(row);
			            else
			            {
				            grdFood.DeleteRow();
				            dso_htrt00060_2_FOOD.Call();
			            }
		            }
	            }      
        break;
        case "ibtnRemoveFood1" :
             for(row = grdBeverage.rows-1; row > 0 ; row--)
	            {
		            if (grdBeverage.GetGridControl().isSelected(row) == true)       
		            {
			            if (grdBeverage.GetGridData(row, 0) == '')
				            grdBeverage.RemoveRowAt(row);
			            else
			            {
				            grdBeverage.DeleteRow();
				            dso_htrt00060_3_BEVER.Call();
			            }
		            }
	            }      
        break;
        case "ibtnRemoveFood2" :
              for(row = grdF_B_Other.rows-1; row > 0 ; row--)
	            {
		            if (grdF_B_Other.GetGridControl().isSelected(row) == true)
		            {
			            if (grdF_B_Other.GetGridData(row, 0) == '')
				            grdF_B_Other.RemoveRowAt(row);
			            else
			            {
				            grdF_B_Other.DeleteRow();
				            dso_htrt00060_4_OTHER.Call();
			            }
		            }
	            }      
        break;
        case "ibtnRemoveFood3" :
              for(row = grdPromotion.rows-1; row > 0 ; row--)
	            {
		            if (grdPromotion.GetGridControl().isSelected(row) == true)
		            {
			            if (grdPromotion.GetGridData(row, 0) == '')
				            grdPromotion.RemoveRowAt(row);
			            else
			            {
				            grdPromotion.DeleteRow();
				            dso_htrt00060_5_PROMOTION.Call();
			            }
		            }
	            }      
        break;
     }
}
function AmountSum(obj)
{
    switch (obj)
    {
        case "grdFood" :
            if(grdFood.col== 10)
                {
                    var price_Qty;
                    price_Qty=(grdFood.GetGridData(grdFood.row, 8)*(grdFood.GetGridData(grdFood.row, 10)));
                    grdFood.SetGridText(grdFood.row, 11,price_Qty)
                }
                SumFoods();
        break;
        case "grdBeverage" :
              if(grdBeverage.col== 9)      
                {
                    var price_Qty;
                    price_Qty=(grdBeverage.GetGridData(grdBeverage.row, 7)*(grdBeverage.GetGridData(grdBeverage.row, 9)));
                    grdBeverage.SetGridText(grdBeverage.row, 10,price_Qty)
                }
                SumBeverages();
        break;
        case "grdF_B_Other" :
              if(grdF_B_Other.col== 9)
                {
                    var price_Qty;
                    price_Qty=(grdF_B_Other.GetGridData(grdF_B_Other.row, 7)*(grdF_B_Other.GetGridData(grdF_B_Other.row, 9)));
                    grdF_B_Other.SetGridText(grdF_B_Other.row, 10,price_Qty)
                }
                SumServiceOthers();   
        break;
        case "grdPromotion" :
              if(grdPromotion.col== 9)
                {
                    var price_Qty;
                    price_Qty=(grdPromotion.GetGridData(grdPromotion.row, 7)*(grdPromotion.GetGridData(grdPromotion.row, 9)));
                    grdPromotion.SetGridText(grdPromotion.row, 10,price_Qty)
                } 
        break;
     }
}
function SumFoods()
{
    if(lstPartyType.value !='PARTY-B')
    {
        var TotalFood=0,TotalAmtPay_Not_Deposit=0,TotalAmtPay_Deposit;
        for(i = 1; i < grdFood.rows; i++)
        {
            TotalFood=Number(TotalFood) + Number(grdFood.GetGridData(i, 11));
        }
        txtAmtFood.text = ''+ TotalFood; 
        TotalAmtPay_Not_Deposit= Number(txtAmtFood.GetData())+ Number(txtAmtServices.GetData())+Number(txtAmtBvg.GetData()) ;
        TotalAmtPay_Deposit=(Number(txtAmtFood.GetData())+ Number(txtAmtServices.GetData())+Number(txtAmtBvg.GetData()) - Number(txtDeposit.GetData())); 
        txtDebt.SetDataText("" + TotalAmtPay_Deposit); 
        txtTotAmt.SetDataText("" + TotalAmtPay_Not_Deposit);
    } 
}
function SumBeverages()  
{
    if(lstPartyType.value !='PARTY-B')
    {
        var TotalFood=0;;
        for(i = 1; i < grdBeverage.rows; i++) 
        {
            TotalFood=TotalFood + Number(grdBeverage.GetGridData(i, 10));
        }
        txtAmtBvg.text = ''+ TotalFood;
        SumFoods();
    }   
}
function SumServiceOthers()
{
    if(lstPartyType.value !='PARTY-B')
    {
        var TotalFood=0;
        for(i = 1; i < grdF_B_Other.rows; i++)
        {
            TotalFood=TotalFood + Number(grdF_B_Other.GetGridData(i, 10));  
        }
        txtAmtServices.text = ''+ TotalFood; 
        SumFoods();
    }
}
function PartyTypeChange()
{
    if(lstPartyType.GetData() =='PARTY-B')
    {
        txtPresence.SetEnable(false); 
        txtReserve.SetEnable(false);
        txtPer_Table.SetEnable(false); 
        txtSumTable.SetEnable(false);
        //txtDeposit.SetEnable(false);  
        txtDebt.SetEnable(false); 
        txtAmtFood.SetEnable(false); 
        txtTotAmt.SetEnable(false); 
        txtPrice_Pers.SetEnable(true);
        txtAmtServices.SetEnable(true); 
        txtAmtBvg.SetEnable(true); 
        //txtContact.text="Buffer";
    }
    else
    {
        txtPrice_Pers.SetEnable(false);
        //txtPrice_Pers.text=0;
        txtPresence.SetEnable(true); 
        txtReserve.SetEnable(true);
        txtPer_Table.SetEnable(true); 
        txtSumTable.SetEnable(true);
        //txtDeposit.SetEnable(true);  
        txtDebt.SetEnable(false); 
        txtAmtFood.SetEnable(false); 
        txtTotAmt.SetEnable(false);
        txtAmtServices.SetEnable(false); 
        txtAmtBvg.SetEnable(false); 
        //txtContact.text="";
    }
}
function SumAmtFood()
{
    var TotalAmtFood=0,TotalAmtPay=0,TotalAmtPay_Deposit=0,l_Deposit=0;
    var TotalPersons,price;
        TotalPersons=Number(txtTotGuest.GetData());
        price=Number(txtPrice_Pers.GetData());
        TotalAmtFood= TotalPersons*price; 
        l_Deposit= Number(txtDeposit.GetData());  
        TotalAmtPay= Number(txtAmtFood.GetData())+Number(txtAmtServices.GetData())+Number(txtAmtBvg.GetData());
        //luu y de not return 0
        TotalAmtPay_Deposit=(Number(txtAmtFood.GetData())+ Number(txtAmtServices.GetData())+Number(txtAmtBvg.GetData()) - Number(txtDeposit.GetData()))
        if(lstPartyType.value !='PARTY-B')
        {
            //alert(TotalAmtPay_Deposit);
            if(l_Deposit > 0 && l_Deposit<= TotalAmtPay)
            {
               txtDebt.SetDataText("" + TotalAmtPay_Deposit); 
            }
            else
            {
                txtDeposit.text='0';
            }
        }
        if(lstPartyType.value =='PARTY-B')
        {
             txtTotAmt.SetDataText("" + TotalAmtPay);
             txtAmtFood.SetDataText("" + TotalAmtFood);  
        }
        //PartyTypeChange();    
}
function OnReport()
 {
    var url = '/reports/ht/rt/htrt00130.aspx?p_pk='+ txtMasterPK.text;
	     System.OpenTargetPage( System.RootURL+url , "newform" );
 }
</script>
<body>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htrt00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_htrt00060"> 
                <input bind="grdSearch" > 
                     <input bind="dtFrom" /> 
                     <input bind="dtTo1" />
                     <input bind="txtSearchSlipNo" />  
                     <input bind="lstPartyTypesearch" />
                </input> 
                <output bind="grdSearch" />   
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htrt00060_mst" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32" function="CRM.sp_sel_htrt00060_1" procedure="CRM.sp_upd_htrt00060_1"> 
			<inout>
				<inout bind="txtMasterPK" />
				<inout bind="txtSlipNo"/>
				<inout bind="dtBookDate"/>
				<inout bind="txtBookTime"/>
				<inout bind="dtOpenDate"/>
				<inout bind="lstBeginTime"/>
				<inout bind="txtDetailTime"/>
				<inout bind="lstPartyType"/>
				<inout bind="txtCustomerID"/>           
				<inout bind="txtCustomerName"/>
				<inout bind="txtMobile"/>
				<inout bind="txtEmail"/>
				<inout bind="txtAddress"/>
				<inout bind="txtDescription"/>
				<inout bind="txtTotGuest"/>
				<inout bind="txtPresence"/>
				<inout bind="txtPer_Table"/>
				<inout bind="txtPrice_Pers"/>
				<inout bind="txtTotAmt"/>
				<inout bind="txtCreator"/>
				<inout bind="txtDeposit"/>
				<inout bind="txtTelephone"/>
				<inout bind="txtReserve"/>	
				<inout bind="txtSumTable"/>
				<inout bind="txtAmtFood"/>
				<inout bind="txtPromotion"/>
				<inout bind="txtAmtBvg"/>
				<inout bind="txtDebt"/>
				<inout bind="lstStatus"/>    
				<inout bind="txtFax"/>	
				<inout bind="txtContact"/>	
				<inout bind="lstCurrency"/>
				<inout bind="txtAmtServices"/>
			</inout>
		</dso> 
	</xml> 
</gw:data>
<!---------------------------------------------------------------------------->
<gw:data id="dso_htrt00060_2_FOOD" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="CRM.SP_SEL_HTRT00060_2_FOOD" procedure="CRM.SP_UPD_HTRT00060_2_FOOD"> 
			<input bind="grdFood">
				<input bind="txtMasterPK" />
			</input> 
			<output bind="grdFood" /> 
		</dso> 
	</xml> 
</gw:data>
<!---------------------------------------------------------------------------->
<gw:data id="dso_htrt00060_3_BEVER" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="CRM.SP_SEL_HTRT00060_3_BEVER" procedure="CRM.SP_UPD_HTRT00060_3_BEVER"> 
			<input bind="grdBeverage">
				<input bind="txtMasterPK" />
			</input> 
			<output bind="grdBeverage" /> 
		</dso> 
	</xml> 
</gw:data>
<!---------------------------------------------------------------------------->
<gw:data id="dso_htrt00060_4_OTHER" onreceive="OnDataReceive(this)">    
	<xml> 
		<dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="CRM.SP_SEL_HTRT00060_4_OTHER" procedure="CRM.SP_upd_HTRT00060_4_OTHER"> 
			<input bind="grdF_B_Other">
				<input bind="txtMasterPK" />
			</input> 
			<output bind="grdF_B_Other" /> 
		</dso> 
	</xml> 
</gw:data>
<!---------------------------------------------------------------------------->
<gw:data id="dso_htrt00060_5_PROMOTION" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="CRM.SP_SEL_HTRT00060_5_PROMOTION" procedure="CRM.SP_upd_HTRT00060_5_PROMOTION"> 
			<input bind="grdPromotion">
				<input bind="txtMasterPK" />
			</input> 
			<output bind="grdPromotion" /> 
		</dso> 
	</xml> 
</gw:data>
<!---------------------------------------------------------------------------->
    <gw:data id="dso_htrt00060_food" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_htrt00060_food"> 
                <input bind="grdItemFood" > 
                     <input bind="lstItemFood" /> 
                </input> 
                <output bind="grdItemFood" />   
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htrt00060_Beverage" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_htrt00060_Beverage"> 
                <input bind="grdItemBeverage" > 
                     <input bind="lstItemBeverage" /> 
                     <input bind="txtItemBeverage" />
                </input> 
                <output bind="grdItemBeverage" />  
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->   
    <gw:data id="dso_htrt00060_others" onreceive="OnDataReceive(this)">       
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_htrt00060_others"> 
                <input bind="grdItemOther" > 
                     <input bind="lstItemOther" /> 
                     <input bind="txtItemOther" />
                </input> 
                <output bind="grdItemOther" />  
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <gw:data id="dso_htrt00060_promotion" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_htrt00060_promotion"> 
                <input bind="grdItemPromotion" > 
                     <input bind="lstItemPromotion" /> 
                     <input bind="txtItemPromotion" />
                </input> 
                <output bind="grdItemPromotion" />  
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background: #BDE9FF" border="0">
        <tr>
            <td style="width: 25%; background: white" align="left" id="left">
                <table style="height: 100%; width: 100%" border="0">
                    <tr>
                        <td style="width: 30%">
                            <b>Book Date</b>
                        </td>
                        <td  style="width: 70%" colspan="2">
                            <gw:datebox id="dtFrom" onchange="OnSearch('Search')" lang="1" styles="width:49%" />
                            ~<gw:datebox id="dtTo1" onchange="OnSearch('Search')" lang="1" styles="width:49%" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn id="btnSearch" img="search" onclick="OnSearch('Search')" alt="Search" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%">
                            Slip No</td>
                        <td style="width: 67%" colspan="3">
                            <gw:textbox id="txtSearchSlipNo" styles="width: 100%" onenterkey="OnSearch('Search')" />
                        </td>
                        
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 30%">
                            Party Type</td>
                        <td style="width: 67%" colspan="3">
                            <gw:list id="lstPartyTypesearch" onchange="OnSearch('Search')" styles="width:100%;" />
                        </td>
                        
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="4">
                            <gw:grid id="grdSearch" header="_PK|Book Date|Slip No|Party Type|Open Date" format="0|4|0|0|4" aligns="0|0|0|0|0"
							defaults="||||" editcol="0|0|0|0|0" widths="0|2000|2000|1500|1000" styles="width:100%;height:100%" autosize='T'
							oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:75%; background: white" align="right" id="right">
              <table valign='top' style="height: 100%; width: 100%" border="0">
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right"></td>
					<td style="width: 20%">
						
					</td>
					<td style="width: 10%" align="right"></td>
					<td style="width: 20%">
					</td>
					<td style="width: 10%" align="right"></td>
					<td style="width: 20%">
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 93%" align="right">
								</td>								
								<td style="width: 3%" align="right">
								</td>
								<td style="width: 3%" align="right">
								</td>
								<td style="width: 3%" align="right">
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Slip No</td>
					<td style="width: 20%">
						<gw:textbox id="txtSlipNo" styles="width: 100%" csstype="mandatory"/>
					</td>
					<td style="width: 10%" align="right">Total.Pers</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtTotGuest" onchange="SumAmtFood()" onenterkey="SumAmtFood()" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/> 
					</td>
					<td style="width: 20%" align="right">
						
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 93%" align="right">
									<gw:imgbtn img="excel" alt="Print" text="Print" id="btnReport" onclick="OnReport()"/>
								</td>								
								<td style="width: 3%" align="right">
									
								</td>
								<td style="width: 3%" align="right">
									
								</td>
								<td style="width: 3%" align="right">
									
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Book Date</td>
					<td style="width: 20%">
						<gw:datebox id="dtBookDate" lang="1" styles="width:100%" />
					</td>
					<td style="width: 10%" align="right">Presence</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtPresence" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/><!--txtPresence--PERSONS_TABLES-->
					</td>
					<td style="width: 20%" align="right">
						Reserve
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtReserve" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/><!--txtReserve--BACKUP_TABLE--> 
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Book Time</td>
					<td style="width: 20%">
						<gw:textbox id="txtBookTime" styles="width: 100%"/>
					</td>
					<td style="width: 10%" align="right">Pers/Table</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtPer_Table" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						Sum Table
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">  
								    <gw:textbox id="txtSumTable" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Open Date</td>
					<td style="width: 20%">
						<gw:datebox id="dtOpenDate" lang="1" styles="width:100%" />
					</td>
					<td style="width: 10%" align="right">Price/Pers</td> 
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtPrice_Pers" onchange="SumAmtFood()" onenterkey="SumAmtFood()" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						Amt.Food
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtAmtFood" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Begin Time</td>
					<td style="width: 20%">
						<gw:list id="lstBeginTime" styles="width:100%;" />
					</td>
					<td style="width: 10%" align="right">Amt.Service</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtAmtServices" onchange="SumAmtFood()" onenterkey="SumAmtFood()" type="number" format="###,###,###,###" styles="text-align:right;width:100%;" />
					</td>
					<td style="width: 10%" align="right">Amt.Bvg</td>   
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtAmtBvg" onchange="SumAmtFood()" onenterkey="SumAmtFood()" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Detail Time</td>
					<td style="width: 20%">
						<gw:textbox id="txtDetailTime" styles="width: 100%"/>
					</td>
					<td style="width: 10%" align="right">Amt.Total </td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtTotAmt" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						Currency
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:list id="lstCurrency" styles="width:100%;" />
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Party Type</td>
					<td style="width: 20%">
						<gw:list id="lstPartyType" onchange="PartyTypeChange()" styles="width:100%;" />
					</td>
					<td style="width: 10%" align="right">Deposit</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtDeposit" onchange="SumAmtFood()" onenterkey="SumAmtFood()" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
					</td>
					<td style="width: 20%" align="right">
						Debt
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtDebt" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Customer</td>
					<td style="width: 20%" colspan="4">
						<gw:textbox id="txtCustomerID" styles="width: 41%"/><gw:textbox id="txtCustomerName" styles="width: 59%"/>
					</td>
					<td style="width: 20%" align="right">   
						Promotion
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtPromotion" type="number" format="###,###,###,###" styles="text-align:right;width:100%;"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Mobile</td>
					<td style="width: 20%">
						<gw:textbox id="txtMobile" styles="width: 100%"/>
					</td>
					<td style="width: 10%" align="right">Telephone</td>  
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtTelephone" styles="width: 100%"/>
					</td>
					<td style="width: 10%" align="right">Status</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:list id="lstStatus" styles="width:100%;" />
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Email</td>
					<td style="width: 20%" colspan="4">
						<gw:textbox id="txtEmail" styles="width: 100%"/>
					</td>
					<td style="width: 20%" align="right">
						Contact
					</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtContact" styles="width: 100%"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
					<td style="width: 10%" align="right">Address</td>
					<td style="width: 20%" colspan="4">
						<gw:textbox id="txtAddress" styles="width: 100%"/>
					</td>
					<td style="width: 10%" align="right">Fax</td>
					<td style="width: 10%">
						<table style="height: 100%; width: 100%">
							<tr>
								<td style="width: 3%" align="right">
								    <gw:textbox id="txtFax" styles="width: 100%"/>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
				<tr style="height: 2%" valign="top">
				    <td>Description</td>
				    <td colspan="4"><gw:textbox id="txtDescription" styles="width:100%" /></td>
				    <td style="width: 10%" align="right">Creator</td>
					<td style="width: 20%" colspan="2">
						<gw:textbox id="txtCreator" styles="width: 100%" csstype="mandatory" />
					</td>
				</tr>
				<!------------------------------------->
				<tr style="height: 76%" valign="top">
			    <td width=100% colspan=7>
			        <table id="RightBottomTB" width="100%" height="100%"  align="top" >
						
							<tr style="height: 100%">
							    <td width="100%">
							        <gw:tab id="idTab_Child"  onclick ="OnchangeTab()">
							        
							            <table name="Menu Foods" id="TabFoods"  align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:145;" >
							                <!-------->
					                            <tr style="height: 1%">
                                                <td colspan="11">
                                                    <fieldset>
                                                        <table style="width: 100%; height: 100%">
                                                            <tr style="height: 1%">
                                                                <td style="width: 18%">
                                                                    Item Group
                                                                </td>
                                                                <td style="width: 30%">
                                                                    <gw:list id="lstItemFood" styles="width: 100%" onchange="OnSearch('grdSearchI_Food')" />
                                                                </td>
                                                                <td style="width: 3%" align="right">
                                                                    
                                                                </td>
                                                                <td style="width: 30%" align="right">
                                                                </td>
                                                                
                                                                <td style="width: 3%" align="right">
                                                                    
                                                                </td>
                                                                <td style="width: 3%" align="right">
									                                <gw:imgbtn id="btnSearchFood" img="search" onclick="OnSearch('grdSearchI_Food')" />
								                                </td>
								                                <td style="width: 3%" align="right">
									                                
								                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
					                            <!-------->	
							                <tr style="width: 100%; height: 33%; background: #BDE9FF">
					                            <td colspan="7" style="width: 100%">
						                            <table style="height: 100%; width: 100%">
							                            <tr style="height: 100%">
								                            <td style="width: 40%; background: white">
									                            <gw:grid id="grdItemFood" 
									                            header="_PK|_Menu_PK|Item Code|Item Name|_Item Group|Unit|Price|_Currency|Qty|Amount|Description" 
									                            format="0|0|0|0|0|0|-0|0|-0|-0|0" 
									                            aligns="0|0|0|0|0|0|3|0|3|3|0"
									                            defaults="||||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|0|0" 
									                            widths="0|0|0|0|1000|2000|2000|1500|2000|2000|1500" 
									                            styles="width:100%;height:100%" 
									                            autosize='T'
									                            oncelldblclick="OnSelectRoom(this)" />
								                            </td>
								                            <td style="width: 5%" align="center">
									                            <gw:icon id="ibtnSelectFood" img="in" text=">>" onclick="OnSelectRoom1(this)" />
									                            </br>
									                            <gw:icon id="ibtnRemoveFood" img="in" text="<<" onclick="OnRemoveRoom(this)" />
								                            </td>
								                            <td style="width: 55%; background: white">
									                            <gw:grid id="grdFood" 
									                            header="_PK|_webbooking_pk|_Item_pk|_Menu_PK|Item Code|Item Name|_Item Group|Unit|Price|_Currency|Qty|Amount|Description" 
									                            format="0|0|0|0|0|1|0|0|1|0|0|1|0" 
									                            aligns="0|0|0|0|3|3|0|0|3|0|3|3|0"
									                            defaults="||||||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|0|1|0|0" 
									                            widths="0|0|0|0|1000|2000|2000|1500|2000|2000|1500|2000|2000" 
									                            styles="width:100%;height:100%" 
									                            autosize='T' check="||||||||||0-||" onafteredit="AmountSum('grdFood')" />
								                            </td>
							                            </tr>
						                            </table>
					                            </td>
				                            </tr>
                                        </table>
                                        <table name="Beverages" id="TabBeverages"    align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:145;" >
                                            <!-------->
					                            <tr style="height: 1%">
                                                <td colspan="11">
                                                    <fieldset>
                                                        <table style="width: 100%; height: 100%">
                                                            <tr style="height: 1%">
                                                                <td style="width: 18%">
                                                                    Item Group
                                                                </td>
                                                                <td style="width: 28%">
                                                                    <gw:list id="lstItemBeverage" styles="width: 100%" onchange="OnSearch('grdSearchI_Beverage')" />
                                                                </td>
                                                                <td style="width: 3%" align="right">
                                                                    Item
                                                                </td>
                                                                <td style="width: 28%" align="right">
                                                                    <gw:textbox id="txtItemBeverage" onenterkey="OnSearch('grdSearchI_Beverage')" styles='width:100%' />
                                                                </td>
                                                                <td style="width: 3%" align="right">
                                                                    
                                                                </td>
                                                                <td style="width: 3%" align="right">
									                                <gw:imgbtn id="btnSearchBeverage" img="search" onclick="OnSearch('grdSearchI_Beverage')" />
								                                </td>
								                                <td style="width: 3%" align="right">
									                                
								                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
					                            <!---grdItemBeverage--grdBeverage--->	
							                <tr style="width: 100%; height: 33%; background: #BDE9FF">
					                            <td colspan="7" style="width: 100%">
						                            <table style="height: 100%; width: 100%">
							                            <tr style="height: 100%">
								                            <td style="width: 40%; background: white">
									                            <gw:grid id="grdItemBeverage" 
									                            header="_PK|Item Code|Item Name|_Item Group|Unit|Price|_Currency|_Qty|_Amount|_Description" 
									                            format="0|0|0|0|0|-0|0|-0|-0|0" 
									                            aligns="0|0|0|0|0|3|0|3|3|0"
									                            defaults="|||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|0" 
									                            widths="0|0|0|1000|2000|2000|1500|2000|2000|1500"  
									                            styles="width:100%;height:100%" 
									                            autosize='T'
									                            oncelldblclick="OnSelectRoom(this)" />
								                            </td>
								                            <td style="width: 5%" align="center">
									                            <gw:icon id="ibtnSelectFood1" img="in" text=">>" onclick="OnSelectRoom1(this)" />
									                            </br>
									                            <gw:icon id="ibtnRemoveFood1" img="in" text="<<" onclick="OnRemoveRoom(this)" />
								                            </td>
								                            <td style="width: 55%; background: white">
									                            <gw:grid id="grdBeverage" 
									                            header="_PK|_webbooking_pk|_Item_pk|Item Code|Item Name|_Item Group|Unit|Price|_Currency|Qty|Amount|Description" 
									                            format="0|0|0|0|1|0|0|1|0|0|1|0" 
									                            aligns="0|0|0|3|3|0|0|3|0|3|3|0"
									                            defaults="|||||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|1|0|0" 
									                            widths="0|0|0|1000|2000|2000|1500|2000|2000|1500|2000|2000" 
									                            styles="width:100%;height:100%" 
									                            autosize='T' check="|||||||||0-||" onafteredit="AmountSum('grdBeverage')" />
								                            </td>
							                            </tr>
						                            </table>
					                            </td>
				                            </tr>
                                        </table>
                                        <table name="Services Other" id="TabOthers"   align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:145;" >
                                            <!-------->
					                            <tr style="height: 1%">  
                                                <td colspan="11">
                                                    <fieldset>
                                                        <table style="width: 100%; height: 100%">
                                                            <tr style="height: 1%">
                                                                <td style="width: 18%">
                                                                    Item Group
                                                                </td>
                                                                <td style="width: 30%">
                                                                    <gw:list id="lstItemOther" styles="width: 100%" onchange="OnSearch('grdSearchI_Other')" />
                                                                </td>
                                                                <td style="width: 3%" align="right">
                                                                    Item
                                                                </td>
                                                                <td style="width: 30%" align="right">
                                                                    <gw:textbox id="txtItemOther" onenterkey="OnSearch('grdSearchI_Other')" styles='width:100%' />
                                                                </td>
                                                                <td style="width: 3%" align="right">
                                                                    
                                                                </td>
                                                                <td style="width: 3%" align="right">
									                                <gw:imgbtn id="btnSearchOther" img="search" onclick="OnSearch('grdSearchI_Other')" />
								                                </td>
								                                <td style="width: 3%" align="right">
									                                
								                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
					                            <!--grdItemOther----grdF_B_Other-->	
							                <tr style="width: 100%; height: 33%; background: #BDE9FF">
					                            <td colspan="7" style="width: 100%">
						                            <table style="height: 100%; width: 100%">
							                            <tr style="height: 100%">
								                            <td style="width: 40%; background: white">
									                            <gw:grid id="grdItemOther" 
									                            header="_PK|Item Code|Item Name|_Item Group|Unit|Price|_Currency|_Qty|_Amount|_Description" 
									                            format="0|0|0|0|0|-0|0|-0|-0|0" 
									                            aligns="0|0|0|0|0|3|0|3|3|0"
									                            defaults="|||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|0" 
									                            widths="0|0|0|1000|2000|2000|1500|2000|2000|1500" 
									                            styles="width:100%;height:100%" 
									                            autosize='T'
									                            oncelldblclick="OnSelectRoom(this)" />
								                            </td>
								                            <td style="width: 5%" align="center">
									                            <gw:icon id="ibtnSelectFood2" img="in" text=">>" onclick="OnSelectRoom1(this)" />
									                            </br>
									                            <gw:icon id="ibtnRemoveFood2" img="in" text="<<" onclick="OnRemoveRoom(this)" />
								                            </td>
								                            <td style="width: 55%; background: white"> 
									                            <gw:grid id="grdF_B_Other" 
									                            header="_PK|_webbooking_pk|_Item_pk|Item Code|Item Name|_Item Group|Unit|Price|_Currency|Qty|Amount|Description" 
									                            format="0|0|0|0|1|0|0|1|0|0|1|0" 
									                            aligns="0|0|0|3|3|0|0|3|0|3|3|0"
									                            defaults="|||||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|1|0|0" 
									                            widths="0|0|0|1000|2000|2000|1500|2000|2000|1500|2000|2000" 
									                            styles="width:100%;height:100%" 
									                            autosize='T' check="|||||||||0-||" onafteredit="AmountSum('grdF_B_Other')" />
								                            </td>
							                            </tr>
						                            </table>
					                            </td>
				                            </tr>
                                        </table>
                                        <table name="Promotions" id="TabPromotions"   align ="top"  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:145;" >
                                            <!-------->
					                            <tr style="height: 1%">
                                                <td colspan="11">
                                                    <fieldset>
                                                        <table style="width: 100%; height: 100%"> 
                                                            <tr style="height: 1%">
                                                                <td style="width: 18%">
                                                                    Item Group
                                                                </td>
                                                                <td style="width: 30%">
                                                                    <gw:list id="lstItemPromotion" styles="width: 100%" onchange="OnSearch('grdSearchI_Promotions')" />
                                                                </td>
                                                                <td style="width: 3%" align="right">
                                                                    Item
                                                                </td>
                                                                <td style="width: 30%" align="right">
                                                                    <gw:textbox id="txtItemPromotion" onenterkey="OnSearch('grdSearchI_Promotions')" styles='width:100%' />
                                                                </td>
                                                                <td style="width: 3%" align="right">
                                                                    
                                                                </td>
                                                                <td style="width: 3%" align="right">
									                                <gw:imgbtn id="btnSearchPromotion" img="search" onclick="OnSearch('grdSearchI_Promotions')" />
								                                </td>
								                                <td style="width: 3%" align="right">
									                                
								                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
					                            <!--grdItemPromotion----grdPromotion-->	
							                <tr style="width: 100%; height: 33%; background: #BDE9FF">
					                            <td colspan="7" style="width: 100%">
						                            <table style="height: 100%; width: 100%">
							                            <tr style="height: 100%">
								                            <td style="width: 40%; background: white">
									                            <gw:grid id="grdItemPromotion" 
									                            header="_PK|Item Code|Item Name|_Item Group|Unit|Price|_Currency|_Qty|_Amount|_Description" 
									                            format="0|0|0|0|0|-0|0|-0|-0|0" 
									                            aligns="0|0|0|0|0|3|0|3|3|0"
									                            defaults="|||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|0" 
									                            widths="0|0|0|1000|2000|2000|1500|2000|2000|1500" 
									                            styles="width:100%;height:100%" 
									                            autosize='T'
									                            oncelldblclick="OnSelectRoom(this)" />  
								                            </td>
								                            <td style="width: 5%" align="center">
									                            <gw:icon id="ibtnSelectFood3" img="in" text=">>" onclick="OnSelectRoom1(this)" />
									                            </br>
									                            <gw:icon id="ibtnRemoveFood3" img="in" text="<<" onclick="OnRemoveRoom(this)" />
								                            </td>
								                            <td style="width: 55%; background: white">
									                            <gw:grid id="grdPromotion" 
									                            header="_PK|_webbooking_pk|_Item_pk|Item Code|Item Name|_Item Group|Unit|Price|_Currency|Qty|Amount|Description" 
									                            format="0|0|0|0|1|0|0|1|0|0|1|0" 
									                            aligns="0|0|0|3|3|0|0|3|0|3|3|0"    
									                            defaults="|||||||||||" 
									                            editcol="0|0|0|0|0|0|0|0|0|1|0|0" 
									                            widths="0|0|0|1000|2000|2000|1500|2000|2000|1500|2000|2000" 
									                            styles="width:100%;height:100%" 
									                            autosize='T' check="|||||||||0-||" onafteredit="AmountSum('grdPromotion')"/>
								                            </td>
							                            </tr>
						                            </table>
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
            </td>
        </tr>
    </table>	
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnClick('OnToggle')" />
</body>
<gw:textbox id="txtMasterPK" styles="display: none" />
<gw:textbox id="tco_buspartner_pk" styles="display: none" />
<!--------------------------------------------------------------------------------------->
</html>
