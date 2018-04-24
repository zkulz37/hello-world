<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head id="Head1" runat="server">
    <title>SALE ORDER ENTRY</title>
</head>

<script>
    var gBarcode = "";
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
    
    var col_update ; // cot can update qty 
    
    var next_col_convert ;   
    
    var is_unit_change = 0;
         
    /*grdMemberFeeD   */
    
    var l_fee_pk  =0,
       l_locate = 1,
       l_invoiceNo = 2,
       total_pay =8,
       l_cardNum = 9;
       
   /*grdGolfer*/
  var   
   v_golfer_pk          =0,
   v_member_fee_pk      =1,
   v_order              =2,
   v_member_pk          =3,
   v_member_id          =4,
   
   v_member_nm          =5,
   v_phone              =6,
   v_gender             =7,
   v_personal_id        =8,
       
   v_card_no            =9,
   v_group              =10,
   v_caddy_pk           =11,
   v_caddy_id           =12,
   v_caddy_nm           =13,
   
   v_caddy_fee          =14,
   v_green_fee          =15,
   v_total_fee          =16,
   v_payed_yn           =17,
   v_checkin            =18,
   v_checkout           =19;
   
  //---------------------------------------------------------
 var iCodeID = "" ;
 var p_update =0;
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
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }

 //---------------------------------------------------------
 function BodyInit()
 {
	OnToggle();
	SetStatus(1);            
	OnResetM();

	var data = '';
	<%=ESysLib.SetGridColumnComboFormatString2( "grdMemberFeeD" , 1 , "3|Pro Shop|2|Mini Bar|3|Kiosk|1|F and B|5|Rental|4|RESTAURANT") %>;
	
	data = "<%=ESysLib.SetListDataSQL("select a.PK, a.NAME from crm.TCM_MEMBER_TYPE a where a.DEL_IF=0 and nvl(a.USE_YN,'N')='Y'  order by a.NAME")%>||";
	cboMemberList.SetDataText(data);
	cboMemberList.value = '';
      
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" )%>"; 
	cboNation.SetDataText(data);
	cboNation.value = 'NAT-VIE';
       
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>"; 
	cboGender.SetDataText(data);
	cboGender.value = 'GEN-M';

	data = "data |9|9|18|18|27|27|36|36";
	lstHoles.SetDataText(data); 
      
	data = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.COURSE_ID ||' - '|| A.COURSE_NAME FROM CRM.TGM_GOLF_COURSE A WHERE A.DEL_IF =0 " ) %> ";	
	lstGolfer.SetDataText(data);
	
	grdGolfer.GetGridControl().ColEditMask(v_card_no)="999";
	grdGolfer.SetComboFormat(v_group,'|#1;Group 1|#2;Group 2|#3;Group 3|#4;Group 4|#5;Group 5');
      
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>"; 
	grdGolfer.SetComboFormat(v_gender,data);
    data ="DATA|USD|USD|VND|VND|EUR|EUR|KRW|KRW"; 
	lstCCY.SetDataText(data); 
	var trl ;      
	trl = grdGolfer.GetGridControl();      	
	trl.ColFormat(v_caddy_fee )         = "###,###,###,###,###";
	trl.ColFormat(v_green_fee )         = "###,###,###,###,###";
	trl.ColFormat(v_total_fee )         = "###,###,###,###,###"; 
	txtTotalFeeVND.SetReadOnly(true); 
	txtExRate.SetReadOnly(true);
	dso_get_exrate_list.Call();
 }

function SetParentPKtoGrid(p_grdId)
{
	for ( i = 1; i < p_grdId.rows ; i++ )
	{
		if ( p_grdId.GetGridData(i,0) == "" )
		{
			p_grdId.SetGridText( i ,1 , txtReceiptPK.text ) ;
		}
	}
}
  
var step = 1 ; 

 function OnPopUp(id)
 {
      switch (id)         
      {		        
	    case 2 :
	         var path = System.RootURL + "/form/ja/bk/jabk0011.aspx?member_no="+txtMemberNo.text;
	         var object = System.OpenModal( path ,800 , 500 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp
	              arrTemp = object[0];
	              OnResetM()
	              txtReceiptPK.text=""
	              
                 chkBooked.text="Y"
                 txtBookPK.text=arrTemp[0]
                 
                 txtMemberNo.text=arrTemp[2] 
                 txtMemberPK.text=arrTemp[1]  
                 cboMemberList.value=arrTemp[3]    
                 txtFullName.text=arrTemp[4] 
                 cboNation.value=arrTemp[5] 
                 
                 txtPassport.text=arrTemp[6] 
                 cboGender.value = arrTemp[7] 
                 txtPhone.text=arrTemp[8] 
                 txtEmail.text=arrTemp[9] 
                 txtComNM.text=arrTemp[10] 
                 
                 txtComPhone.text=arrTemp[11] 
                 txtTax.text=arrTemp[12] 
                 txtAdress.text=arrTemp[13] 
                 txtNoGuest.text=arrTemp[15]
                 lstHoles.value=arrTemp[16]

				 txtTeeTime.text = arrTemp[18];                 
                 lstGolfer.value=arrTemp[19]
                 txtMemPhotoPK.text=arrTemp[14]                  


                 grdMemberFeeD.ClearData()
                 imgMember.SetDataText(txtMemPhotoPK.text );
                 txtTraningFee.text=0
                 txtOther.text=0
                 lblstatus.text ='NEW'
                 OnSearch(7)
                // data_CaddyBook.Call('SELECT')
	         }
	    break;     
	    case 3:
	        if (txtBookPK.text == "")
	        {
	        var path = System.RootURL + '/form/ja/bk/jabk0031.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( obj != null )
             { 
                 txtFullName.text   = obj[2];
                 txtAdress.text     = obj[7];
                 txtTax.text        = obj[6];
                 txtComPhone.text   = obj[10];
                 txtComNM.text      = "";
                 
                 txtEmail.text      = obj[11];
                 cboNation.value    = obj[37];

             }  
           } else
           {
                alert('Cannot change customer!')
           }
           
	    break;  
	    case 1:
			var path = System.RootURL + "/form/ja/bk/jabk0032.aspx?golf_type="+lstGolfer.value+"&day="+dtOrderDate.value+"";
            var obj = System.OpenModal( path ,730 , 350,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                  txtTeeTime.text	= obj[0];
                  dtOrderDate.value	= obj[1];
            }	        
	    break;                                  
      }         
 }  

 function OnSaveDTL()
 {
	data_ReceiptGolfer.Call();	
 }
 //----------------------------------------------

 function OnNewGolfer()
 {
    grdGolfer.AddRow()
	grdGolfer.SetGridText(grdGolfer.rows -1,v_member_fee_pk, txtReceiptPK.text);
    grdGolfer.SetGridText(grdGolfer.rows -1,v_order,grdGolfer.rows -1);
    grdGolfer.SetGridText(grdGolfer.rows -1,v_gender,'GEN-M');
    grdGolfer.SetGridText(grdGolfer.rows -1,v_group,'1');
    txtNoGuest.text = grdGolfer.rows-1
    MandatoryColor()
 }
 
 //----------------------------------------------
 function OnGolferDouble()
 {
     if((event.col == v_caddy_id || event.col == v_caddy_nm )&& event.row >0 )
    {
         var path = System.RootURL + "/form/ja/rc/jarc0010_caddy.aspx";
	         var object = System.OpenModal( path ,500 , 300 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp
	              arrTemp = object[0];
	              grdGolfer.SetGridText(grdGolfer.row,v_caddy_pk,arrTemp[0])//caddy pk
	              grdGolfer.SetGridText(grdGolfer.row,v_caddy_id ,arrTemp[1])//caddy Id
	              grdGolfer.SetGridText(grdGolfer.row,v_caddy_nm ,arrTemp[2])//caddy Id
                
	         }
    }else if(event.col == v_member_id && event.row >0)
    {
         var path = System.RootURL + "/form/ja/rc/jarc0010_member.aspx";
	         var object = System.OpenModal( path ,500 , 300 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp
	              arrTemp = object[0];
	              grdGolfer.SetGridText(grdGolfer.row,v_member_pk,arrTemp[0])//member pk
	              grdGolfer.SetGridText(grdGolfer.row,v_member_id ,arrTemp[1])//member Id
	              grdGolfer.SetGridText(grdGolfer.row,v_member_nm ,arrTemp[2])//member Id
	              grdGolfer.SetGridText(grdGolfer.row,v_gender ,arrTemp[4])//gender
	              grdGolfer.SetGridText(grdGolfer.row,v_phone ,arrTemp[5])//phone
	              grdGolfer.SetGridText(grdGolfer.row,v_personal_id ,arrTemp[12])//personal
                
	         }
    }  
    else if(event.col == 9 && event.row >0)//card no
    {
         var path = System.RootURL + "/form/ja/bs/jabs00050_Popup.aspx";
	         var object = System.OpenModal( path ,500 , 300 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp;
	            arrTemp = object[0];
	            if(arrTemp[2]==20)
	            {
	                alert("Card no is using.");
	            }
	            else
	            {
	              grdGolfer.SetGridText(grdGolfer.row,9,arrTemp[1])//card no
	             }
	         }
    }      
    
 }
 
    var p_update = 0 ;
 //---------------------------------------------------------
 
 function OnSave(pos)
 {
    //if (CheckSave())
    //{
      switch (pos)         
      {		        
            case 1 :
				if (confirm('Are your sure check in ?'))
				{
					if(CheckSaveValid())
					{
						data_getMaster.Call();
						p_update = 1 ;
					}
				}
            break;
            case 2:
                SetParentPKtoGrid(grdGolfer);
                data_ReceiptGolfer.Call();
            break;

      }  
    //}
 }

 function OnReportClick(obj)
 {
     alert('This report will be developed follow customer form !')
 }
var flag_dtl=0;
//=======================================yyyyyyyyyyyyyyy=======================================
function OnSearch(pos)
 {
     switch(pos)
     {
        case 1:
            data_listofCheckIn.Call('SELECT');
        break;
        /*Search pk neu co*/
        case 2:
           txtSearchFlag.text = '1';
           txtCardInput.text =  txtCardId.text;
           data_CheckReceiptPK.Call()           
        break;
        case 3:
           txtSearchFlag.text = '2';
           txtCardInput.text =  txtMemberNo.text;
           data_CheckReceiptPK.Call()           
        break;
        case 4: //search master
             data_getMaster.Call('SELECT')
        break;
        case 5: //search master
             tabMain.SetPage(0)
            data_listofMemberD.Call('SELECT')
            flag_dtl=0;
        break;
        case 6: //search master
            data_CaddyFee.Call('SELECT')
        break;
       case 7: //Search Booking Golfer
            data_BookGolfer.Call('SELECT')
        break;
        case 8: //Receipt Caddy
            data_CaddyFee1.Call('SELECT')
        break;
        case 9: //Search Receipt Golfer
            data_ReceiptGolfer.Call('SELECT')
        break;
     }
 }

 //---------------------------------------------------------
 function OnDataReceive(po_oData)
 {
     switch(po_oData.id)
     {
       
        case "data_CheckReceiptPK":
            if(txtReceiptPK.text=="")
            {
              OnPopUp(2);
            }else
            {
                txtSearchFlag.text ="";
                txtCardInput.text ="";
                OnSearch(4)
            }
        case "data_getMaster":
            idBtnSaveD.SetEnable(true); 
             imgMember.SetDataText(txtMemPhotoPK.text );
             if(lblstatus.text == 'CHECKED OUT')
             {
                idBtnCheckIn.SetEnable(false);
                idBtnCheckOut.SetEnable(false);
             }else
             {
                idBtnCheckIn.SetEnable(true);
                idBtnCheckOut.SetEnable(true);
             }
             if(p_update==1)
            {
                p_update=0;
                OnSave(2)
            }else
            {            
                
             OnSearch(5);
            }
           // data_listofMemberD.Call('SELECT');
        break;
        case "data_listofMemberD":
           //TotalAmount()
            OnSearch(9)
            flag_dtl=0;
        break;
      /* case "data_CaddyFee1":
            TotalAmount()
            OnSearch(9)
        break; */
        case "data_Checkout":
            OnSearch(4)
        break;
        case "data_CaddyFee":
            OnSearch(7)
        break; 
        case "data_BookGolfer":
            for(var i =1; i<grdGolfer.rows; i++)
            {
                grdGolfer.SetRowStatus(i,48)
            }
             txtNoGuest.text = grdGolfer.rows-1
             MandatoryColor()
        break;
    //end switch
     case "data_ReadCard":
         if (txtCardId.text=="0" || txtCardId.text=="" )
         {
            alert("Unregistered Card!")
         }else
         {
            OnSearch(2); //Search Receip
         }
     break;
     case "data_ReceiptGolfer":
            txtNoGuest.text = grdGolfer.rows-1;
            MandatoryColor();
            TotalAmount();
            data_listofCheckIn.Call('SELECT');
     break;
     }
 }

 //------------------------------------------------------------------
 function TotalAmount()
 {
    var sum ,sum_bar,sum_shop,sum_kiosk,sum_fand,sum_rental,set_ExRate,sum_caddy, sum_greens,total_fee_vnd
    sum =0
    sum_bar =0
    sum_shop =0
    sum_kiosk =0
    sum_fand =0
    sum_rental =0  
    sum_caddy   =0
    sum_greens  =0
    total_fee_vnd=0
    for(i=1; i<grdMemberFeeD.rows; i++ )
    {
        var dValueTotal
        
       dValueTotal = grdMemberFeeD.GetGridData(i,total_pay) ;
       
       if ( Number(dValueTotal) )
       {
            sum = sum + parseFloat(dValueTotal);
       }
        var temp = grdMemberFeeD.GetGridData(i,l_locate)+""
        switch(temp)
       {

       case '3':
            dValueTotal = grdMemberFeeD.GetGridData(i,total_pay) ;
             if ( Number(dValueTotal) )
               {
                    sum_shop = sum_shop + parseFloat(dValueTotal);
               }
       break;
        case '2':
             dValueTotal = grdMemberFeeD.GetGridData(i,total_pay) ;
             if ( Number(dValueTotal) )
               {
                    sum_bar = sum_bar + parseFloat(dValueTotal);
               }
       break;
       case '3':
            dValueTotal = grdMemberFeeD.GetGridData(i,total_pay) ;
             if ( Number(dValueTotal) )
               {
                    sum_kiosk = sum_kiosk + parseFloat(dValueTotal);
               }
       break;
       case '1':
            dValueTotal = grdMemberFeeD.GetGridData(i,total_pay) ;
             if ( Number(dValueTotal) )
               {
                    sum_fand = sum_fand + parseFloat(dValueTotal);
               }
       break;
       case '5':
            dValueTotal = grdMemberFeeD.GetGridData(i,total_pay) ;
             if ( Number(dValueTotal) )
               {
                    sum_rental = sum_rental + parseFloat(dValueTotal);
               }
       break;
      }
    }
    for(i=1; i<grdGolfer.rows; i++ )
    {
        var d_fee
        
        d_fee = grdGolfer.GetGridData(i,v_caddy_fee) ;
        if ( Number(d_fee) )
           {
                sum_caddy = sum_caddy + parseFloat(d_fee);
           }
        d_fee = grdGolfer.GetGridData(i,v_green_fee) ;
        if ( Number(d_fee) )
           {
                sum_greens = sum_greens + parseFloat(d_fee);
           }
        
    }
    
    sum = sum + Number(txtTraningFee.text) + Number(txtOther.text) + Number(sum_caddy) + Number(sum_greens)
    txtTotalFee.text = sum.toFixed(3)+""
    total_fee_vnd=sum*Number(txtExRate.GetData()); 
    txtTotalFeeVND.text = total_fee_vnd +"";
    txtMiniBar.text =sum_bar.toFixed(3)+"";
    txtProShop.text = sum_shop.toFixed(3)+"";
    txtRental.text = sum_rental.toFixed(3)+"";
    txtKiosk.text = sum_kiosk.toFixed(3)+"";    
    
    txtFandB.text = sum_fand.toFixed(3)+"";  
    
    txtGreen.text = sum_greens.toFixed(3)+"";
    txtCaddyFee.text = sum_caddy.toFixed(3)+"";
 }

/*------------------------------------------------------*/
function OnResetM()
{
     txtReceiptPK.text=""
     dtOrderDate.text="" 
     txtCardId.text=""
     chkBooked.text="N"
     txtBookPK.text=""
     
     txtMemberNo.text=""
     txtMemberPK.text=""  
     cboMemberList.value=""    
     txtFullName.text=""
     cboNation.value=""
     
     txtPassport.text=""
     txtPhone.text=""
     txtEmail.text=""
     txtComNM.text=""
     
     txtComPhone.text=""
     txtTax.text=""
     txtAdress.text=""
     txtNoGuest.text=""
     txtMemPhotoPK.text=""
     
     txtTraningFee.text=""
     txtOther.text=""
    txtMiniBar.text="";
    txtProShop.text="";
    
    txtRental.text="";
    txtKiosk.text="";            
    txtFandB.text="";
    txtTotalFee.text="";
    
    txtGreen.text="";
    txtCaddyFee.text="";
    
    idBtnCheckIn.SetEnable(true);
    idBtnCheckOut.SetEnable(true);
    
    tabMain.SetPage(1)
    dso_get_exrate_list.Call();
    
    if(data_getMaster.GetStatus() != 20)
    {
        data_getMaster.StatusInsert();
        grdMemberFeeD.ClearData();
        grdGolfer.ClearData();
        idBtnSaveD.SetEnable(false); 
    }
     
}
//---------------------------------------------------------
 function SetStatus(pos)
 {
      switch (pos)         
      {		        
        case 1 :
            chkBooked.SetEnable(false);
            txtMiniBar.SetEnable(false);
            txtProShop.SetEnable(false);
            
            txtRental.SetEnable(false);
            txtKiosk.SetEnable(false);            
            txtFandB.SetEnable(false);
            cboMemberList.SetEnable(false);
            txtTotalFee.SetEnable(false);
            
            txtGreen.SetEnable(false);
            txtCaddyFee.SetEnable(false);  
			
			txtTeeTime.SetReadOnly(true);  

        break;
     }  
 } 


function OnCheckOut()
{
    if(txtReceiptPK.text!="")
    {
        data_Checkout.Call()
    }
}


 //---------------------------------------------------------
 function OnDelete(obj)
 {
    var ctrl = obj.GetGridControl();

	var row  = ctrl.row;
		
	if ( row > 0  ) 
	{
		if ( obj.GetGridData( ctrl.row, 0 ) == "" ) 
	    {						
		
				obj.RemoveRow();
				txtNoGuest.text = grdGolfer.rows-1					
		}			
		else 
		{
			if ( confirm( "Do you want to mark this row to delete?" ) ) 
			{
				obj.DeleteRow();
			}
		}
	}

 }
 //---------------------------------------------------------
// function OnUnDelete(obj) 
// {
//		
//	obj.UnDeleteRow()
//		
// }
//-----------------------------------------------------------
function CheckSaveValid()
{
    if(txtFullName.text =="")
    {
        alert('Please, input customer name!')
        return false;
    }
     for (var i = 1; i< grdGolfer.rows; i++)
    {
        if(grdGolfer.GetGridData(i,v_member_nm) =="")
            {
                alert('Please, input player name in Payer Info grid!')
                 return false;
            }
        if(grdGolfer.GetGridData(i,v_card_no) =="")
            {
                alert('Please, input Card No for each player!')
                 return false;
            }
         if(grdGolfer.GetGridData(i,v_caddy_pk) =="")
            {
                alert('Please, Select Caddy for each player!')
                 return false;
            }
    }
    return true;
}
function OnView()
{
     if (txtReceiptPK.text!="")
        { 
              var url = System.RootURL + "/system/ReportEngine.aspx?file=ja/rc/jarc0010.rpt&procedure=CRM.sp_rpt_jarc0010_2|CRM.sp_rpt_jarc0010_3&parameter=" + txtReceiptPK.text + "|" + txtReceiptPK.text+"&export_pdf=Y" ;              
             //  var url = System.RootURL + "/system/ReportEngine.aspx?file=ja/rc/111.rpt&procedure=CRM.sp_rpt_jarc0010_2|CRM.sp_rpt_jarc0010_3&parameter=" + txtReceiptPK.text + "|" + txtReceiptPK.text ;              
	          System.OpenTargetPage(url); 
        }       
        else
        {    
              alert("Please,Select a receipt to print !");
        }
}
function OnPrintRC()
{
     if (txtReceiptPK.text!="")
        { 
              var url = System.RootURL + "/system/ReportEngine.aspx?file=ja/rc/jarc0010.rpt&procedure=CRM.sp_rpt_jarc0010_2|CRM.sp_rpt_jarc0010_3&parameter=" + txtReceiptPK.text + "|" + txtReceiptPK.text+"&print_yn=Y" ;              
	          System.OpenTargetPage(url); 
        }       
        else
        {    
              alert("Please,Select a receipt to print !");
        }
}
function MandatoryColor()
{
    if (grdGolfer.rows >1)
    {
		grdGolfer.SetCellBgColor( 1, v_member_id , grdGolfer.rows - 1, v_member_id , 0xCCFFFF );
		grdGolfer.SetCellBgColor( 1, v_member_nm , grdGolfer.rows - 1, v_member_nm , 0xCCFFFF );
		grdGolfer.SetCellBgColor( 1, v_card_no , grdGolfer.rows - 1, v_card_no , 0xCCFFFF );
		grdGolfer.SetCellBgColor( 1, v_caddy_id , grdGolfer.rows - 1, v_caddy_id , 0xCCFFFF );
		grdGolfer.SetCellBgColor( 1, v_caddy_nm , grdGolfer.rows - 1, v_caddy_nm , 0xCCFFFF );
    }
}
function OnShowScan()
{
    if( img2.status == "up")
    {
         idScan.style.display =''
         img2.status="down"
         img2.src="../../../system/images/down.gif"
        
    }else
    {
        idScan.style.display ='none'
        img2.status="up"
        img2.src="../../../system/images/up.gif"
        
    }
}
function OnMemberFeeDetail()
{
    if(grdMemberFeeD.row > 0 )
    {
         var customfeed_pk =""
         var cardNum =""
         var invoiceNo =""
         customfeed_pk = grdMemberFeeD.GetGridData(grdMemberFeeD.row,l_fee_pk);
         cardNum = grdMemberFeeD.GetGridData(grdMemberFeeD.row,l_cardNum);
         invoiceNo = grdMemberFeeD.GetGridData(grdMemberFeeD.row,l_invoiceNo);
         var path = System.RootURL + "/form/ja/rc/jarc0010_fee_detail.aspx?customFeeDPK="+customfeed_pk+"&cardNum="+cardNum+"&invoiceNo="+invoiceNo;         
         var object = System.OpenModal( path ,600 , 400 ,  'resizable:yes;status:yes');
     }            
}
</script>
<SCRIPT LANGUAGE=javascript FOR=Scanner EVENT="BCReceiveEvent">
        if(gBarcode != sBarcode ) 	
        {	
			if (sBarcode.length == 38)
			{
				gBarcode = sBarcode;
				//alert(sBarcode) //sBarcode bien cua Scanner
				//txtBarcode.text='BB0222000E3000E2008073710E02140560DD95'
				txtBarcode.text=Trim(sBarcode);	             
				data_ReadCard.Call()
            }             
        }  
</SCRIPT> 
<body>
    <!---------------------------------->
        <gw:data id="dso_get_exrate_list" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_GET_RATE1" > 
                <input> 
                     <input bind="lstCCY"/>
                </input>
                <output>
                     <output bind="txtExRate"/>
                     <output bind="txtTR_RATE1"/> 
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_listofCheckIn" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm"   parameter="0,1,2,3" function="crm.sp_sel_jarc0010_1" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtIDSearch" /> 
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>  
    <!---------------------------------tim pk cua member fee--------------------------------->
    <gw:data id="data_CheckReceiptPK" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="crm.sp_pro_jarc0010_1" > 
                <input>
                     <input bind="txtCardInput" /> 
                     <input bind="txtSearchFlag" /> 
                </input> 
                <output> 
                    <output bind="txtReceiptPK" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
     <!-------------------------------Get Master Infor----------------------------------->
    <gw:data id="data_getMaster" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,22,23,24,25,26,27" function="crm.sp_sel_jarc0010_2" procedure="sp_upd_jarc0010_2"> 
                <inout> 
                    <inout bind="txtReceiptPK" />
                    <inout bind="dtOrderDate" />  
                    <inout bind="txtCardId" />
                    <inout bind="chkBooked" />
                    <inout bind="txtBookPK" />
                    
                    <inout bind="txtMemberNo" />
                    <inout bind="txtMemberPK" />           
                    <inout bind="cboMemberList" />                    
                    <inout bind="txtFullName" />
                    <inout bind="cboNation" /> 
                    
                    <inout bind="txtPassport" />
                    <inout bind="cboGender" />                            
                    <inout bind="txtPhone" />  
                    <inout bind="txtEmail" /> 
                    <inout bind="txtComNM" /> 
                    
                    <inout bind="txtComPhone" /> 
                    <inout bind="txtTax" /> 
                    <inout bind="txtAdress" /> 
                    <inout bind="txtNoGuest" /> 
                    <inout bind="txtMemPhotoPK" /> 
                    
                    <inout bind="txtTraningFee" /> 
                    <inout bind="txtOther" /> 
                    <inout bind="cboCurrent" /> 
                    <inout bind="lblstatus" /> 
                    <inout bind="lstHoles" /> 
                    
                    <inout bind="lstGolfer" /> 
                    
					<inout bind="txtTeeTime" /> 
					<inout bind="txtExRate" /> 
					
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------tim pk cua member fee--------------------------------->
    <gw:data id="data_Checkout" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="crm.sp_upd_jarc0010_3" > 
                <input>
                     <input bind="txtReceiptPK" /> 
                </input> 
                <output> 
                    <output bind="txtresult" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
     <!------------------------------------------------------------------>
    <gw:data id="data_listofMemberD" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm"    function="crm.sp_sel_jarc0010_3" > 
                <input> 
                     <inout bind="txtReceiptPK" />
                </input> 
                <output bind="grdMemberFeeD" /> 
            </dso> 
        </xml> 
    </gw:data>  
      <!-------------------------------Receipt Golfer----------------------------------->
    <gw:data id="data_ReceiptGolfer" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19"    function="CRM.sp_sel_jarc0010_4" procedure="CRM.sp_upd_jarc0010_4" > 
                <input> 
                     <inout bind="txtReceiptPK" />
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data>
   
     <!-------------------------------Booking Golfer----------------------------------->
    <gw:data id="data_BookGolfer" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="crm"    function=" CRM.sp_sel_jarc0010_5" > 
                <input> 
                     <inout bind="txtBookPK" />
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------read Card--------------------------------->
    <gw:data id="data_ReadCard" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="CRM.sp_pro_jarc0010_READCARD" > 
                <input>
                     <input bind="txtBarcode" /> 
                </input> 
                <output> 
                    <output bind="txtCardId" />
                </output>
            </dso> 
        </xml> 
    </gw:data> 
   
    <table style="width: 100%; height: 100%" border="1" >
        <tr>
            <td id='left' style="width: 25%">
                <table style="width: 100%; height: 100%" >
                    <tr style="height: 2%">
                        <td align="right" style="width: 30%">
                            <b>Date</b>
                        </td>
                        <td style="width: 79%">
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                            ~<gw:datebox id="dtTo" lang="1" styles="width:100%" onchange="OnSearch(1)" />
                        </td>
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnOrderNoSearch" img="search" onclick='OnSearch(1)' />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 20%; white-space: nowrap">
                            <b>Card/Member ID</b></td>
                        <td >
                            <gw:textbox id="txtIDSearch" csstype="mandatory" styles="width:100%" onenterkey="OnSearch(1)" />
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Member ID|_Card No|Customer Name|Date" format="0|0|0|0|4" aligns="0|0|0|0|0"
                                defaults="|||||" editcol="0|0|0|0|0" widths="0|1500|1200|1000|1200" styles="width:100%; height:100%"
                                sorting="T" acceptnulldate="true"  autosize="T"
                                oncellclick="txtReceiptPK.text=grdSearch.GetGridData(grdSearch.row,0)+'';OnSearch(4)"  />
                        </td>
                    </tr>
                </table>
            </td>
            <td id='right' style="width: 100%">
                <table style="width: 100%; height: 100%" >
                    <tr style="height: 1%;width: 100%">
                        <td colspan='12'>
                            <table style="width: 100%; height: 100%" cellspacing="0" cellpadding="1" border="0">
                                <tr>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>CheckIn Date</b>
                                    </td>
                                    <td style="width: 10%">
                                        <gw:datebox id="dtOrderDate" lang="1" />
                                    </td>
                                    <td style="width: 10%; white-space: nowrap" align="right">
                                        <b>Card No</b>
                                    </td>
                                    <td style="width: 25%">
                                        <gw:textbox id="txtCardId" styles='width:100%' csstype="mandatory" onenterkey="OnSearch(2)" />
                                     </td>                                    
                                    <td style="width: 15%">
                                        <gw:icon id="idBook" img="2" text="Booking List" alt="Find Booking List" styles='width:100%'
                                            onclick="OnPopUp(2)" />
                                    </td>                                    
                                    <td style="width: 2%" align="left">
                                        <gw:icon id="idBtnNew" img="2" text="New" alt="New" styles='width:100%'
                                            onclick="OnResetM()"  />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:icon id="idBtnCheckIn" img="2" text="Check In" styles='width:100%' onclick="OnSave(1)" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:icon id="idBtnCheckOut" img="2" text="Check Out" styles='width:100%' onclick="OnCheckOut()" />
                                    </td>
                                    <td style="width: 5%" align="right">
                                        <gw:icon id="idBtnDelete" img="2" text="Delete" styles='width:100%' onclick="OnDeleteM()" />
                                    </td>
                                     <td style="width: 2%" align="right">
                                        <gw:icon id="idBtnCheckPrint" img="2" text="Report" styles='width:100%' onclick="OnView()" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:icon id="idBtnReport" img="2" text="Print Bill" styles='width:100%' onclick="OnPrintRC()" />
                                    </td>
                                </tr>
                                
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%;width: 100%" >
                       
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>Member No</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:textbox id="txtMemberNo" styles='width:100%' csstype="mandatory" onenterkey="OnSearch(3)" />
                            <gw:textbox id="txtMemberPK" styles='width:100%;display:none'  />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>Member Type</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:list id="cboMemberList" styles="width:100%" />
                        </td>
                        <td colspan='2' align="center"><gw:label id="lblstatus" styles="color:red"></gw:label></td>
                        <td colspan='3' rowspan='5' style="width: 100%; vertical-align:middle" align="center" >
                             <gw:image id="imgMember" table_name="CRM.TGM_MEMBERPHOTO" procedure="CRM.SP_UPD_TGM_MEMBERPHOTO" oid="0" view="/binary/ViewFile.aspx"
                                            post="/binary/PostFile.aspx" styles="width:90%;height:90%" style='border: 1px solid #1379AC' />

                        </td>
                    </tr>
                    <tr style="height: 1%;width: 100%" >
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>
                        <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(3)">Customer Name</b>
                        </td>
                        <td style="width: 25%" colspan='3'>
                             <gw:textbox id="txtFullName" styles='width:100%' csstype="mandatory" onenterkey="" />
                        </td>
                         <td style="width: 5%; white-space: nowrap" align="right" >Nation</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:list id="cboNation" styles="width:100%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right" >Passport</td>
                        <td style="width: 15%" >
                            <gw:textbox id="txtPassport" styles='width:100%'  onenterkey="" />
                        </td>                      
                       
                    </tr>
                    <tr style="height: 1%;width: 100%" >
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'><b style="color: Red">*</b>Gender</td>
                        <td style="width: 20%" colspan='2'>
                             <gw:list id="cboGender" styles="width:100%" >                              
                             </gw:list>
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>Mobile Phone</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:textbox id="txtPhone" styles='width:100%'  onenterkey="" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right" >Email</td>
                        <td style="width: 15%" >
                            <gw:textbox id="txtEmail" styles='width:100%'  onenterkey="" />
                        </td>                        
                       
                    </tr>
                     <tr style="height: 1%;width: 100%" >
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>Company Name</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:textbox id="txtComNM" styles='width:100%'  onenterkey="" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>Company Phone</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:textbox id="txtComPhone" styles='width:100%'  onenterkey="" />
                        </td>   
                        <td style="width: 5%; white-space: nowrap" align="right" >Tax Code</td>
                        <td style="width: 15%" >
                            <gw:textbox id="txtTax" styles='width:100%'  onenterkey="" />
                        </td>                        
                       
                    </tr>
                  <tr style="height: 1%;width: 100%" >
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>Company Address</td>
                        <td style="width: 20%" colspan='8'>
                            <gw:textbox id="txtAdress" styles='width:100%'  onenterkey="" />
                        </td>                        
                    </tr>
                    <tr style="height: 1%;width: 100%" >
                         <td style="width: 10%; white-space: nowrap" align="right" colspan='2' >Total Player</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:textbox id="txtNoGuest" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                        </td> 
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'><b style="color: Red">*</b>Holes</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:list id="lstHoles" styles="color:blue;width:100%" />
                        </td> 
                        <td style="width: 10%; white-space: nowrap" align="right" >Booked</td>
                        <td style="width: 20%" >
                             <gw:checkbox id="chkBooked" defaultvalue="Y|N" />
                             <gw:textbox id="txtBookPK" styles='width:100%;display:none'   />
                        </td> 
                       <td style="width: 5%; white-space: nowrap" align="right" ></td>
                        <td style="width: 5%" >
                        </td>   
                    </tr>
					<tr style="height: 1%;width: 100%" >
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2'>Golf Type</td>
                        <td style="width: 20%" colspan='2'>
                            <gw:list id="lstGolfer" styles="color:blue;width:100%" />
                        </td> 
                        <td style="width: 10%; white-space: nowrap" align="right" colspan='2' >
							<b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(1)"><b style="color: Red">*</b>Tee Time</b>
						</td>
                        <td style="width: 20%" colspan='2'>
							<gw:textbox id="txtTeeTime" styles='width:100%;'   />
                        </td> 
                        <td style="width: 10%; white-space: nowrap" align="right" >Ex.Rate</td>
                        <td style="width: 20%" >
                        <gw:textbox id="txtExRate" styles='width:100%;' type='number' format="###,###.###"  onenterkey="" /></td> 
                       <td style="width: 5%; white-space: nowrap" align="right" ></td>
                        <td style="width: 5%" >
                        </td>   
                    </tr>
                    <!---------------------------------------------------------------->
                    <tr style="height: 25%">   
                        <td colspan='12'>
                            <fieldset style="padding:1; width: 100%; height:95%">
                               <legend><font color="black" size="2"><b></b></font></legend>
                            <table width=100% style="height:100%" cellpadding='0' cellspacing='0'>
                                 <tr style="width:100%; height:5%">                                 
                                     <td style="width: 10%; white-space: nowrap" align="right" >Training Fee &nbsp;&nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtTraningFee" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                    <td style="width: 10%; white-space: nowrap" align="right" >Mini Bar Fee &nbsp;&nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtMiniBar" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                   <td style="width: 10%; white-space: nowrap" align="right" >Kiosk &nbsp;&nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtKiosk" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td>  
                                    
                                </tr>
                                <tr style="width:100%; height:5%">
                                     <td style="width: 10%; white-space: nowrap" align="right" >Caddy Fee &nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtCaddyFee" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                  
                                     <td style="width: 10%; white-space: nowrap" align="right" >Pro Shop &nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtProShop" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                     <td style="width: 10%; white-space: nowrap" align="right" >F and B &nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtFandB" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                    
                                </tr>
                                <tr style="width:100%; height:5%">
                                    <td style="width: 10%; white-space: nowrap" align="right" >Greens Fee &nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtGreen" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td>                            
                                  
                                    <td style="width: 10%; white-space: nowrap" align="right" >Rental &nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtRental" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                     <td style="width: 10%; white-space: nowrap" align="right" >Other Fee &nbsp;</td>
                                    <td style="width: 20%" >
                                        <gw:textbox id="txtOther" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                  
                                </tr>                               
                            </table>
                             </fieldset>
                        </td>
                    </tr>
                    <!---------------------------------------------------------------->
                    <tr style="height: 45%">
                        <td colspan='12'>
                           <gw:tab id="tabMain"  border=1 style="width:100%;height:99%" onpageactivate="" > 	
                            <table name="Bill Info" style="width: 100%; height: 100%">
                                <tr style="height:5%"> 
                                    <td style="width: 5%; white-space: nowrap" align="right" >Total Fee(USD)</td>
                                    <td style="width: 10%" >
                                        <gw:textbox id="txtTotalFee" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                    
                                    <td style="width: 5%; white-space: nowrap; display:none" align="right" >Discount</td>
                                    <td style="width: 10%" >
                                        <gw:textbox id="txtTotalDis" styles='width:100%  ;display:none' type='number' format="###,###.###"  onenterkey="" />
                                    </td> 
                                    <td style="width: 5%; white-space: nowrap; display:none" align="right" >Total Pay</td>
                                    <td style="width: 10%" >
                                        <gw:textbox id="txtTotalPay" styles='width:100%; display:none' type='number' format="###,###.###"  onenterkey="" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap; display:none" align="right" >Ex Pay</td>
                                    <td style="width: 10%" >
                                        <gw:textbox id="txtTotalExPay" styles='width:100%; display:none' type='number' format="###,###.###"  onenterkey="" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" align="right" >Total Fee(VND)</td>
                                    <td style="width: 10%" >
                                        <gw:textbox id="txtTotalFeeVND" styles='width:100%' type='number' format="###,###.###"  onenterkey="" />
                                    </td>  
                                     <td  style="width: 1%; white-space: nowrap; display:none" align="right"  >Currency</td>
                                    <td  style="width: 10%; white-space: nowrap; display:none" align="right" >
                                        <gw:list id="cboCurrent" value="VND" styles="width:100%" >
                                            <data>|USA|USD|VND|VND</data>
                                         </gw:list>
                                    </td>                                     
                                  </tr>                                
                               <tr style="height:95%">
                                    <td colspan="16">
                                       <gw:grid id='grdMemberFeeD'
                                        header='_pk|Location|Invoice No|Invoice Dt|Amount|Discount|Vat(%)|Vat Amount|Pay Amount|Card No'
                                        format='0|0|0|0|1|1|1|1|1|0'
                                        aligns='0|0|0|0|0|0|0|0|1'
                                        defaults='||||||||'
                                        editcol='0|0|0|0|0|0|0|0|0'
                                        widths='1000|1000|2000|1000|1000|1000|1000|1000|1000'
                                        sorting='T'
                                        autosize ='T'
                                        styles='width:100%; height:100%'
                                        oncelldblclick="OnMemberFeeDetail()"
                                        />
                                    </td>
                               </tr>
                            </table>
                            <table name="Player Info" style="width: 100%; height: 100%">
                               <tr style="height:5%"> 
                                    <td style="width: 92%; white-space: nowrap" align="left" >
                                    <img status="up" id="img2" src="../../../system/images/up.gif" style="cursor: hand"  alt="Show Scan Card No Component" onclick="OnShowScan()" />
                                     </td>
                                    <td style="width: 2%" >
                                        <gw:imgbtn id="idBtnSaveD" img="save" text="Save" alt="Save" styles='width:100%'
                                            onclick="OnSaveDTL()" />
                                    </td> 
                                    <td style="width: 2%" >
                                        <gw:imgbtn id="idBtnNewM" img="new" text="Add" alt="New" styles='width:100%'
                                            onclick="OnNewGolfer()" />
                                    </td> 
                                    <td style="width: 2%" >
                                        <gw:imgbtn id="idBtnDelM" img="delete" alt="Delete" text="Delete" styles='width:100%'
                                            onclick="OnDelete(grdGolfer)" />
                                    </td> 
                                    <!--<td style="width: 2%" >
                                        <gw:imgbtn id="idBUnDelM" img="UDelete" alt="Delete" text="Delete" styles='width:100%'
                                            onclick="OnUnDelete(grdGolfer)" />
                                    </td> -->
                                    <td></td>
                                  </tr>  
                                  <tr style="height:94%">
                                    <td colspan="5">
                                      <gw:grid id='grdGolfer'
                                        header='_GOLFER_PK|_MEMBERFEE_PK|No|_MEMBER_PK|Member No|Player Name|Phone|Gender|Personal ID/(Passport)|Card No|Player Group|_CADDY_PK|Caddy Id|Caddy Name|Caddy Fee|Greens Fee|Others Fee|Payed YN|Check In Time|Check Out Time'
                                        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|3|0|0'
                                        aligns='0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|0|0|0|0'                                        
                                        defaults='|||||||||||||||||||'
                                        editcol='0|0|0|0|0|1|1|1|1|0|1|0|1|1|0|0|0|1|0|0'
                                        widths='0|0|800|0|1500|2500|1000|1000|1000|1500|1000|0|1500|2500|1500|1000|1500|1500'
                                        sorting='T'
                                        autosize ='T'
                                        oncelldblclick="OnGolferDouble()"
                                        styles='width:100%; height:100%'
                                        />
                                    </td>
                               </tr>
                               <tr id="idScan" style="display:none"  >                               
                                    <td colspan="4">
                                        <OBJECT ID="Scanner"
                                        CLASSID="CLSID:0C6B7553-403E-4630-B9AD-6EBD85A8B50B"
                                        CODEBASE="=../../../system/activex/ScannerControl.CAB#version=1,0,0,0">
                                        </OBJECT>
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
    <!------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
        position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!------------------------------------------->
    <gw:textbox id="txtReceiptPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtTR_RATE1" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtCardInput" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtSearchFlag" maxlen="100" styles='width:100%;display:none' />
    
    <gw:textbox id="txtMemPhotoPK" text="" style="display: none" />
    <gw:list id="lstCCY" styles="width:100%;display:none" />
    <gw:textbox id="txtBillToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliToPK1" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtDeliLocPK" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtEmpPK" maxlen="100" styles='width:100%;display:none' />
    <!------------------Convert UOM------------------------->
    <gw:textbox id="txtOrderUOM" styles='width:100%;display:none' />
    <gw:textbox id="txtUOM" styles='width:100%;display:none' />
    <gw:textbox id="txtQtyOfOderUOM" styles='width:100%;display:none' />
    <gw:textbox id="txtQtyAfterConvert" styles='width:100%;display:none' />
    <!------------------------------------------->
    <gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
    <gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
    <!------------------------------------------->
    <gw:textbox id="txtQtyFormat" styles='width:100%;display:none' />
    <gw:textbox id="txtNumberOfDecimal" styles='width:100%;display:none' />
    <!-------------------------------------------->
    <gw:textbox id="txtresult" styles='width:100%;display:none' />
    <gw:textbox id="txtItem_pk" styles='width:100%;display:none' />
    <!-------------------------------------------->
    <gw:textbox id="txtBarcode" styles='width:100%;display:none' />
</body>
</html>
