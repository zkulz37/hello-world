<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	Response.ContentType = "application/x-excel" 
	Response.Charset = "utf-8"
%>
<%
	dim compk
	
	compk = Request.QueryString("compk")
	custpk = Request.QueryString("custpk")
	status  = Request.QueryString("status")
	sdt = Request.QueryString("sdt")
	edt = Request.QueryString("edt")
	
	
	
SQL= "SELECT '' CHK  "& _
	"		, A.PK PPK "& _
	"		, (SELECT MAX(H.PK) FROM TAC_BGTRH H WHERE H.TR_TABLE_PK = A.TR_SEQ AND H.DEL_IF = 0 AND H.TR_TABLENM = 'TFN_BAPAYTR' ) HPK "& _
	"		, A.VOUCHERNO VOUCHER_NO "& _
	"		, A.PAY_DATE TR_DATE "& _
	"		, '' SIGN_DATE "& _
	"		, 0 TR_DATE_SEQ "& _
	"		, SF_A_GET_REF_PL(D.PK) PL_NM "& _
	"		, A.TR_REMARK TR_REMARK "& _
	"		, A.TR_REMARK2  TR_REMARK2  "& _
	"		, C.CUST_ID CUST_ID "& _
	"		, C.CUST_NM CUST_NM "& _
	"		, decode(A.PAY_TYPE, '22', DECODE(A.PAY_CCY, 'USD',to_char(a.PAY_FAMT, '999,999,9999,999,990.99'), ''), '21', DECODE(A.PAY_CCY, 'USD',to_char(a.PAY_FAMT, '999,999,9999,999,990.99'), ''), '')  bank_usd "& _
	"		, decode(A.PAY_TYPE, '22', DECODE(A.PAY_CCY, 'USD','', to_char(a.PAY_FAMT, '999,999,9999,999,990.99')), '21', DECODE(A.PAY_CCY, 'USD','', to_char(a.PAY_FAMT, '999,999,9999,999,990.99')), '')  bank_vnd "& _
	"		, decode(A.PAY_TYPE, '12', DECODE(A.PAY_CCY, 'USD',to_char(a.PAY_FAMT, '999,999,9999,999,990.99'), ''), '11', DECODE(A.PAY_CCY, 'USD',to_char(a.PAY_FAMT, '999,999,9999,999,990.99'), ''), '') cash_usd "& _
	"		, decode(A.PAY_TYPE, '12', DECODE(A.PAY_CCY, 'USD','', to_char(a.PAY_FAMT, '999,999,9999,999,990.99')), '11', DECODE(A.PAY_CCY, 'USD','', to_char(a.PAY_FAMT, '999,999,9999,999,990.99')), '') cash_vnd "& _
	"		, a.PAY_MEMB "& _
	"		, decode(A.PAY_TYPE, '22', DECODE(A.PAY_CCY, 'USD',a.PAY_FAMT, 0), '21', DECODE(A.PAY_CCY, 'USD',a.PAY_FAMT, 0), 0)   "& _
	"		, decode(A.PAY_TYPE, '22', DECODE(A.PAY_CCY, 'USD',0, a.PAY_FAMT), '21', DECODE(A.PAY_CCY, 'USD',0, a.PAY_FAMT), 0)   "& _
	"		, decode(A.PAY_TYPE, '12', DECODE(A.PAY_CCY, 'USD',a.PAY_FAMT, 0), '11', DECODE(A.PAY_CCY, 'USD',a.PAY_FAMT, 0), 0)  "& _
	"		, decode(A.PAY_TYPE, '12', DECODE(A.PAY_CCY, 'USD',0, a.PAY_FAMT), '11', DECODE(A.PAY_CCY, 'USD',0, a.PAY_FAMT), 0)  "& _
	"	   FROM TFN_BAPAYTR A, COMM.TCO_DCCUST C, TAC_BGTRH H, TAC_BGTRD D "& _
	"	  WHERE A.TCO_DCCUSTM_PK = C.PK "& _
	"		AND A.TCO_EOCOMPANY_PK LIKE DECODE('" & compk & "','','%%','" & compk & "')  "& _
	"		AND DECODE(NVL('" & custpk & "' ,NULL),NULL,1,A.TCO_DCCUSTM_PK) = DECODE(NVL('" & custpk & "',NULL),NULL,1,'" & custpk & "') "& _
	"		AND A.PAY_DATE  BETWEEN  '" & sdt & "' AND  '" & edt & "' "& _
	"		AND A.DEL_IF = 0 "& _
	"		AND H.DEL_IF = 0 "& _
	"		AND D.DEL_IF = 0 "& _
	"		AND H.PK = D.TAC_BGTRH_PK  "& _
	"		AND D.PK = A.TAC_BGTRD_PK "& _
	"		AND C.PK = D.TCO_DCCUSTM_PK "& _
	"		AND (H.VOUCHERNO LIKE '%' || trim(UPPER('')) || '%' OR H.VOUCHERNO IS NULL) "
	
	SQL= "SELECT '' CHK  "& _ 
	"		, PPK "& _ 
	"		, HPK  "& _
	"		, VOUCHER_NO  "& _
	"		, TR_DATE "& _ 
	"		, SIGN_DATE  "& _
	"		, TR_DATE_SEQ  "& _
	"		, PL_NM  "& _
	"		, min(TR_REMARK)  "& _
	"		, min(TR_REMARK2)   "& _
	"		, CUST_ID  "& _
	"		, CUST_NM  "& _
	"		, to_char(sum(bank_usd), '999,999,9999,999,990.99')  "& _
	"		, to_char(sum(bank_vnd), '999,999,9999,999,990.99')  "& _
	"		, to_char(sum(cash_usd), '999,999,9999,999,990.99')  "& _
	"		, to_char(sum(cash_vnd), '999,999,9999,999,990.99')  "& _
	"		, min(PAY_MEMB)  "& _
	"		, sum(bank_usd)  "& _
	"		, sum(bank_vnd)  "& _
	"		, sum(cash_usd)  "& _
	"		, sum(cash_vnd)  "& _
	"  FROM ( SELECT '' CHK   "& _
	"			, A.PK PPK  "& _
	"			, (SELECT MAX(H.PK) FROM TAC_BGTRH H WHERE H.TR_TABLE_PK = A.TR_SEQ AND H.DEL_IF = 0 AND H.TR_TABLENM = 'TFN_BAPAYTR' ) HPK  "& _
	"			, A.VOUCHERNO VOUCHER_NO  "& _
	"			, A.PAY_DATE TR_DATE  "& _
	"			, '' SIGN_DATE  "& _
	"			, 0 TR_DATE_SEQ  "& _
	"			, SF_A_GET_REF_PL(D.PK) PL_NM  "& _
	"			, A.TR_REMARK TR_REMARK  "& _
	"			, A.TR_REMARK2  TR_REMARK2   "& _
	"			, C.CUST_ID CUST_ID  "& _
	"			, C.CUST_NM CUST_NM  "& _
	"			, a.PAY_MEMB  "& _
	
	"			, decode(A.PAY_TYPE, '22', DECODE(A.TR_CCY, 'USD', a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), '21', DECODE(A.TR_CCY, 'USD',a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), 0) bank_usd    "& _
	"			, decode(A.PAY_TYPE, '22', DECODE(A.TR_CCY, 'USD', 0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), '21', DECODE(A.TR_CCY, 'USD',0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), 0) bank_vnd    "& _
	"			, decode(A.PAY_TYPE, '12', DECODE(A.TR_CCY, 'USD', a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), '11', DECODE(A.TR_CCY, 'USD',a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), 0) cash_usd    "& _
	"			, decode(A.PAY_TYPE, '12', DECODE(A.TR_CCY, 'USD', 0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), '11', DECODE(A.TR_CCY, 'USD',0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), 0) cash_vnd		  "& _
	"		   FROM TFN_BAPAYTR A, COMM.TCO_DCCUST C, TAC_BGTRH H, TAC_BGTRD D  "& _
	"		  WHERE A.TCO_DCCUSTM_PK = C.PK  "& _
	"			AND A.TCO_EOCOMPANY_PK LIKE DECODE('" & compk & "','','%%','" & compk & "')  "& _
	"			AND DECODE(NVL('" & custpk & "' ,NULL),NULL,1,A.TCO_DCCUSTM_PK) = DECODE(NVL('" & custpk & "',NULL),NULL,1,'" & custpk & "') "& _
	"			AND A.PAY_DATE  BETWEEN  '" & sdt & "' AND  '" & edt & "' "& _
	"			AND A.DEL_IF = 0  "& _
	"			AND H.DEL_IF = 0  "& _
	"			AND D.DEL_IF = 0  "& _
	"			AND H.PK = D.TAC_BGTRH_PK   "& _
	"			AND D.PK = A.TAC_BGTRD_PK  "& _
	"			AND C.PK = D.TCO_DCCUSTM_PK  "& _
	"			AND (H.VOUCHERNO LIKE '%' || trim(UPPER('')) || '%' OR H.VOUCHERNO IS NULL)  "& _
	"		UNION ALL "& _
	"		SELECT '' CHK  "& _ 
	"			, A.PK PPK  "& _
	"			, (SELECT MAX(H.PK) FROM TAC_BGTRH H WHERE H.TR_TABLE_PK = A.TR_SEQ AND H.DEL_IF = 0 AND H.TR_TABLENM = 'TFN_BAPAYTR' ) HPK  "& _
	"			, A.VOUCHERNO VOUCHER_NO  "& _
	"			, A.PAY_DATE TR_DATE  "& _
	"			, '' SIGN_DATE  "& _
	"			, 0 TR_DATE_SEQ  "& _
	"			, SF_A_GET_REF_PL(D.PK) PL_NM  "& _
	"			, A.TR_REMARK TR_REMARK  "& _
	"			, A.TR_REMARK2  TR_REMARK2   "& _
	"			, C.CUST_ID CUST_ID  "& _
	"			, C.CUST_NM CUST_NM  "& _
	"			, a.PAY_MEMB  "& _
	"			, decode(A.PAY_TYPE, '22', DECODE(A.PAY_CCY, 'USD',F.FEE_FAMT, 0), '21', DECODE(A.PAY_CCY, 'USD',F.FEE_FAMT, 0), 0) bank_usd   "& _
	"			, decode(A.PAY_TYPE, '22', DECODE(A.PAY_CCY, 'USD',0, F.FEE_FAMT), '21', DECODE(A.PAY_CCY, 'USD',0, F.FEE_FAMT), 0) bank_vnd   "& _
	"			, decode(A.PAY_TYPE, '12', DECODE(A.PAY_CCY, 'USD',F.FEE_FAMT, 0), '11', DECODE(A.PAY_CCY, 'USD',F.FEE_FAMT, 0), 0) cash_usd   "& _
	"			, decode(A.PAY_TYPE, '12', DECODE(A.PAY_CCY, 'USD',0, F.FEE_FAMT), '11', DECODE(A.PAY_CCY, 'USD',0, F.FEE_FAMT), 0) cash_vnd   "& _
	"		   FROM TFN_BAPAYTR A, COMM.TCO_DCCUST C, TAC_BGTRH H, TAC_BGTRD D, TFN_BAPAYTR_FEE F  "& _
	"		  WHERE A.TCO_DCCUSTM_PK = C.PK  "& _
	"			AND A.TCO_EOCOMPANY_PK LIKE DECODE('" & compk & "','','%%','" & compk & "')  "& _
	"			AND DECODE(NVL('" & custpk & "' ,NULL),NULL,1,A.TCO_DCCUSTM_PK) = DECODE(NVL('" & custpk & "',NULL),NULL,1,'" & custpk & "') "& _
	"			AND A.PAY_DATE  BETWEEN  '" & sdt & "' AND  '" & edt & "' "& _
	"			AND A.DEL_IF = 0  "& _
	"			AND H.DEL_IF = 0  "& _
	"			AND D.DEL_IF = 0  "& _
	"			AND F.DEL_IF = 0 "& _
	"			AND A.PK = F.TFN_BAPAYTR_PK "& _
	"			AND H.PK = D.TAC_BGTRH_PK   "& _
	"			AND D.PK = A.TAC_BGTRD_PK  "& _
	"			AND C.PK = D.TCO_DCCUSTM_PK  "& _
	"			AND (H.VOUCHERNO LIKE '%' || trim(UPPER('')) || '%' OR H.VOUCHERNO IS NULL)  "& _
	"	) GROUP BY  PPK, HPK,VOUCHER_NO, TR_DATE, SIGN_DATE, TR_DATE_SEQ, PL_NM, CUST_ID, CUST_NM " 
			
			
	
SQL =  "SELECT * "& _
				"FROM (SELECT '' CHK  "& _ 
				"		, PPK "& _ 
				"		, HPK  "& _
				"		, VOUCHER_NO  "& _
				"		, TR_DATE "& _ 
				"		, SIGN_DATE  "& _
				"		, TR_DATE_SEQ  "& _
				"		, PL_NM  "& _
				"		, min(TR_REMARK)  "& _
				"		, min(TR_REMARK2)   "& _
				"		, CUST_ID  "& _
				"		, CUST_NM  "& _
				"		, to_char(sum(bank_usd), '999,999,9999,999,990.99')  "& _
				"		, to_char(sum(bank_vnd), '999,999,9999,999,990.99')  "& _
				"		, to_char(sum(cash_usd), '999,999,9999,999,990.99')  "& _
				"		, to_char(sum(cash_vnd), '999,999,9999,999,990.99')  "& _
				"		, min(PAY_MEMB)  "& _
				"		, to_char(sum(bk_amt), '999,999,9999,999,990.99')  "& _
				
				"		, sum(bank_usd)  "& _
				"		, sum(bank_vnd)  "& _
				"		, sum(cash_usd)  "& _
				"		, sum(cash_vnd)  "& _
				"		, sum(bk_amt)  "& _
				"		, 'A' ORD,TAC_BFDEPOMT_PK  "& _
				"  FROM ( SELECT '' CHK   "& _
				"			, A.PK PPK  "& _
				"			, (SELECT MAX(H.PK) FROM TAC_BGTRH H WHERE H.TR_TABLE_PK = A.TR_SEQ AND H.DEL_IF = 0 AND H.TR_TABLENM = 'TFN_BAPAYTR' ) HPK  "& _
				"			, A.VOUCHERNO VOUCHER_NO  "& _
				"			, A.PAY_DATE TR_DATE  "& _
				"			, '' SIGN_DATE  "& _
				"			, 0 TR_DATE_SEQ  "& _
				"			, SF_A_GET_REF_PL(D.PK) PL_NM  "& _
				"			, A.TR_REMARK TR_REMARK  "& _
				"			, A.TR_REMARK2  TR_REMARK2   "& _
				"			, C.CUST_ID CUST_ID  "& _
				"			, C.CUST_NM CUST_NM  "& _
				"			, a.PAY_MEMB  "& _
				
				"			, decode(A.PAY_TYPE, '22', DECODE(A.TR_CCY, 'USD', a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), '21', DECODE(A.TR_CCY, 'USD',a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), 0) bank_usd    "& _
				"			, decode(A.PAY_TYPE, '22', DECODE(A.TR_CCY, 'USD', 0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), '21', DECODE(A.TR_CCY, 'USD',0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), 0) bank_vnd    "& _
				"			, decode(A.PAY_TYPE, '12', DECODE(A.TR_CCY, 'USD', a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), '11', DECODE(A.TR_CCY, 'USD',a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), 0) cash_usd    "& _
				"			, decode(A.PAY_TYPE, '12', DECODE(A.TR_CCY, 'USD', 0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), '11', DECODE(A.TR_CCY, 'USD',0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), 0) cash_vnd		  "& _
				"			, A.PAY_AMT bk_amt , a.TAC_BFDEPOMT_PK TAC_BFDEPOMT_PK "& _
				"		   FROM TFN_BAPAYTR A, COMM.TCO_DCCUST C, TAC_BGTRH H, TAC_BGTRD D  "& _
				"		  WHERE A.TCO_DCCUSTM_PK = C.PK  "& _
				"			AND A.TCO_EOCOMPANY_PK LIKE DECODE('" & compk & "','','%%','" & compk & "')  "& _
				"			AND DECODE(NVL('" & custpk & "' ,NULL),NULL,1,A.TCO_DCCUSTM_PK) = DECODE(NVL('" & custpk & "',NULL),NULL,1,'" & custpk & "') "& _
				"			AND A.PAY_DATE  BETWEEN  '" & sdt & "' AND  '" & edt & "' "& _
				"			AND A.DEL_IF = 0  "& _
				"			AND H.DEL_IF = 0  "& _
				"			AND D.DEL_IF = 0  "& _
				"			AND H.PK = D.TAC_BGTRH_PK   "& _
				"			AND D.PK = A.TAC_BGTRD_PK  "& _
				"			AND C.PK = D.TCO_DCCUSTM_PK  "& _
				"			AND (H.VOUCHERNO LIKE '%' || trim(UPPER('')) || '%' OR H.VOUCHERNO IS NULL)  "& _
				"	) GROUP BY  PPK, HPK,VOUCHER_NO, TR_DATE, SIGN_DATE, TR_DATE_SEQ, PL_NM, CUST_ID, CUST_NM ,TAC_BFDEPOMT_PK "& _
				"	UNION ALL "& _
				"		SELECT '' CHK    "& _
				"			, 0 PPK   "& _
				"			, 0 HPK   "& _
				"			, 'AAAA' VOUCHER_NO   "& _
				"			, '' TR_DATE   "& _
				"			, '' SIGN_DATE   "& _
				"			, 0 TR_DATE_SEQ   "& _
				"			, '' PL_NM   "& _
				"			, '' TR_REMARK   "& _
				"			, '' TR_REMARK2   "& _ 
				"			, CUST_ID   "& _
				"			, CUST_NM   "& _
				"			, to_char(sum(bank_usd), '999,999,9999,999,990.99')  "& _ 
				"			, to_char(sum(bank_vnd), '999,999,9999,999,990.99')  "& _ 
				"			, to_char(sum(cash_usd), '999,999,9999,999,990.99')  "& _ 
				"			, to_char(sum(cash_vnd), '999,999,9999,999,990.99')  "& _ 
				"			, '' PAY_MEMB   "& _
				"			, to_char(sum(bk_amt), '999,999,9999,999,990.99')   "& _
				"			, sum(bank_usd)   "& _
				"			, sum(bank_vnd)   "& _
				"			, sum(cash_usd)   "& _
				"			, sum(cash_vnd)   "& _
				"			, sum(bk_amt)   "& _
				"			, 'B' ORD, max(TAC_BFDEPOMT_PK) "& _
				"	   FROM (SELECT C.CUST_ID CUST_ID   "& _
				"				, C.CUST_NM CUST_NM   "& _
				"				, decode(A.PAY_TYPE, '22', DECODE(A.TR_CCY, 'USD', a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), '21', DECODE(A.TR_CCY, 'USD',a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), 0) bank_usd     "& _
				"				, decode(A.PAY_TYPE, '22', DECODE(A.TR_CCY, 'USD', 0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), '21', DECODE(A.TR_CCY, 'USD',0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), 0) bank_vnd     "& _
				"				, decode(A.PAY_TYPE, '12', DECODE(A.TR_CCY, 'USD', a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), '11', DECODE(A.TR_CCY, 'USD',a.TR_FAMT, decode(C.VENDOR_TRAD,'IM',a.TR_AMT,0)), 0) cash_usd     "& _
				"				, decode(A.PAY_TYPE, '12', DECODE(A.TR_CCY, 'USD', 0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), '11', DECODE(A.TR_CCY, 'USD',0, decode(C.VENDOR_TRAD,'IM',0, a.TR_FAMT)), 0) cash_vnd		   "& _
				"				, A.PAY_AMT bk_amt,a.TAC_BFDEPOMT_PK TAC_BFDEPOMT_PK "& _
				"			   FROM TFN_BAPAYTR A, COMM.TCO_DCCUST C, TAC_BGTRH H, TAC_BGTRD D   "& _
				"			  WHERE A.TCO_DCCUSTM_PK = C.PK   "& _
				"				AND A.TCO_EOCOMPANY_PK LIKE DECODE('" & compk & "','','%%','" & compk & "')  "& _
				"				AND DECODE(NVL('" & custpk & "' ,NULL),NULL,1,A.TCO_DCCUSTM_PK) = DECODE(NVL('" & custpk & "',NULL),NULL,1,'" & custpk & "') "& _
				"				AND A.PAY_DATE  BETWEEN  '" & sdt & "' AND  '" & edt & "'  "& _
				"				AND A.DEL_IF = 0   "& _
				"				AND H.DEL_IF = 0   "& _
				"				AND D.DEL_IF = 0   "& _
				"				AND H.PK = D.TAC_BGTRH_PK    "& _
				"				AND D.PK = A.TAC_BGTRD_PK   "& _
				"				AND C.PK = D.TCO_DCCUSTM_PK   "& _
				"				AND (H.VOUCHERNO LIKE '%' || trim(UPPER('')) || '%' OR H.VOUCHERNO IS NULL)   "& _
					
				"		) GROUP BY CUST_ID, CUST_NM "& _
				"	) ORDER BY  TAC_BFDEPOMT_PK, cust_id,ord		"
	
	TableReadOpen rs, SQL				
	If Not rs.EOF Then
		result 	= rs.GetRows()
		total 	= Ubound(result, 2) + 1
	else
		total = 0
	End If
%>	
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="16000_payment_files/filelist.xml">
<link rel=Edit-Time-Data href="16000_payment_files/editdata.mso">
<link rel=OLE-Object-Data href="16000_payment_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Tuyen</o:LastAuthor>
  <o:LastPrinted>2006-11-29T07:56:54Z</o:LastPrinted>
  <o:Created>2006-10-31T07:47:43Z</o:Created>
  <o:LastSaved>2006-11-29T07:57:36Z</o:LastSaved>
  <o:Company>poslilama</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in 0in .25in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>List of payment</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>26</x:ActiveRow>
       <x:RangeSelection>$A$27:$F$27</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='List of payment'!$7:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1417 style='border-collapse:
 collapse;table-layout:fixed;width:1067pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=334 style='mso-width-source:userset;mso-width-alt:12214;
 width:251pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=110 span=5 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=5 height=21 class=xl61 width=611 style='height:15.95pt;
  width:460pt'>POSLILAMA E&amp;C CO.,Ltd</td>
  <td class=xl26 width=145 style='width:109pt'></td>
  <td class=xl36 width=111 style='width:83pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'>In Change</td>
  <td class=xl25 width=110 style='border-left:none;width:83pt'>Ass. Manager</td>
  <td class=xl25 width=110 style='border-left:none;width:83pt'>Chief Accountant</td>
  <td class=xl25 width=110 style='border-left:none;width:83pt'>G. Director</td>
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=8 class=xl26 style='height:15.95pt;mso-ignore:colspan'></td>
  <td rowspan=4 class=xl44 style='border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl51 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=4 class=xl51 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=4 class=xl51 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=4 class=xl26 style='height:15.95pt;mso-ignore:colspan'></td>
  <td class=xl62>LIST OF PAYMENT</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=4 class=xl26 style='height:15.95pt;mso-ignore:colspan'></td>
  <td class=xl63><%
 	d1 = right(sdt, 2)
	m1 = mid(sdt, 5,2)
	y1 = left(sdt,4)
	d2 = right(edt, 2)
	m2 = mid(edt, 5,2)
	y2 = left(edt,4)
 
  %>At date <%=d2%>/<%=m2%>/<%=y2%></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=8 class=xl26 style='height:15.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 colspan=10 class=xl26 style='height:9.95pt;mso-ignore:colspan'></td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td rowspan=2 height=58 class=xl55 style='height:43.9pt'>No</td>
  <td rowspan=2 class=xl56 style='border-bottom:.5pt solid black'>Seq</td>
  <td rowspan=2 class=xl57 width=110 style='border-bottom:.5pt solid black;
  width:83pt'>Voucher <br>
    No</td>
  <td rowspan=2 class=xl57 width=75 style='border-bottom:.5pt solid black;
  width:56pt'>Payment <br>
    date</td>
  <td rowspan=2 class=xl55>Description</td>
  <td rowspan=2 class=xl55>Supplier</td>
  <td colspan=2 class=xl55 style='border-left:none'>By Transfer</td>
  <td colspan=2 class=xl55 style='border-left:none'>By Cash</td>
  <td rowspan=2 class=xl58 width=110 style='border-bottom:.5pt solid black;
  border-top:none;width:83pt'>Book <br>
    amount</td>
  <td rowspan=2 class=xl55>Receiver</td>
 </tr>
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl55 style='height:21.95pt;border-top:none;border-left:
  none'>USD</td>
  <td class=xl55 style='border-top:none;border-left:none'>VND</td>
  <td class=xl55 style='border-top:none;border-left:none'>USD</td>
  <td class=xl55 style='border-top:none;border-left:none'>VND</td>
 </tr>

 <%
 dim project_tmp
 sum_bank_usd = 0
 sum_bank_vnd = 0
 sum_cash_usd = 0
 sum_cash_vnd = 0
 sum_bk_amt = 0
 
 If total > 0 Then
 	For i=1 to total
		pay_date = result(4,i-1)
		pay_date = right(pay_date, 2) + "/" + mid(pay_date, 5,2) + "/" + left(pay_date,4)
		ord = result(23,i-1)
	%>		
	 <%if ord = "B" then%>
	 <tr class=xl26 height=42 style='mso-height-source:userset;height:32.1pt'>
	  <td height=42 class=xl31 style='height:32.1pt;border-top:none' x:num></td>
	  <td class=xl31 style='border-left:none' x:num></td>
	  <td class=xl41 style='border-left:none'></td>
	  <td class=xl42 style='border-left:none'></td>
	  <td class=xl47 width=334 style='border-left:none;width:251pt'	 >					</td>
	  <td class=xl48 width=145 style='border-left:none;width:109pt'>					<%=result(11,i-1)%></td>
	  <td class=xl49 align=right style='border-left:none' x:num="">						<%=result(12,i-1)%></td>
	  <td class=xl50 align=right style='border-left:none' x:num="">						<%=result(13,i-1)%></td>
	  <td class=xl49 align=right style='border-left:none' x:num="">						<%=result(14,i-1)%></td>
	  <td class=xl50 align=right style='border-left:none' x:num="">						<%=result(15,i-1)%></td>
	  <td class=xl49 align=right style='border-top:none;border-left:none'	  x:num="">	<%=result(17,i-1)%></td>
	  <td class=xl49 style='border-top:none;border-left:none'></td>
	 </tr>
	 <%else%>
	 <%numPage =numPage + 1%>
	 <%
		bank_usd = result(18,i-1)
		bank_vnd = result(19,i-1)
		cash_usd = result(20,i-1)
		cash_vnd = result(21,i-1)
		bk_amt = result(22,i-1)
		
		sum_bank_usd = CDbl(sum_bank_usd) + CDbl(bank_usd)
		sum_bank_vnd = CDbl(sum_bank_vnd) + CDbl(bank_vnd)
		
		sum_cash_usd = CDbl(sum_cash_usd) + CDbl(cash_usd)
		sum_cash_vnd = CDbl(sum_cash_vnd) + CDbl(cash_vnd)
		
		sum_bk_amt = CDbl(sum_bk_amt) + CDbl(bk_amt)
	 %>
	 <tr class=xl26 height=42 style='mso-height-source:userset;height:32.1pt'>
	  <td height=42 class=xl38 style='height:32.1pt;border-top:none' x:num><%=numPage%></td>
	  <td class=xl31 style='border-top:none;border-left:none' x:num><%=result(2,i-1)%></td>
	  <td class=xl41 style='border-top:none;border-left:none'><%=result(3,i-1)%></td>
	  <td class=xl42 style='border-top:none;border-left:none'><%=pay_date%></td>
	  <td class=xl32 width=334 style='border-top:none;border-left:none;width:251pt'		  ><%=result(8,i-1)%></td>
	  <td class=xl33 width=145 style='border-top:none;border-left:none;width:109pt' x:num=""><%=result(11,i-1)%></td>
	  <td class=xl34 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(12,i-1)%></td>
	  <td class=xl35 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(13,i-1)%></td>
	  <td class=xl34 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(14,i-1)%></td>
	  <td class=xl35 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(15,i-1)%></td>
	  <td class=xl34 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(17,i-1)%></td>
	  <td class=xl34 style='border-top:none;border-left:none'><%=result(16,i-1)%></td>
	 </tr>
	 <%end if%>
  <% 
  	Next
 End If
 %>
 
 <% If total > 0 Then %>
	 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
	  <td colspan=6 height=29 class=xl64 style='border-right:.5pt solid black;
	  height:21.95pt'>Grand Total</td>
	  <td class=xl43 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_bank_usd%></td>
	  <td class=xl67 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_bank_vnd%></td>
	  <td class=xl43 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_cash_usd%></td>
	  <td class=xl67 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_cash_vnd%></td>
	  <td class=xl43 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_bk_amt%></td>
	  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
	 </tr>
  <% End If%>
 
 <%
  TableReadOpen rs, "SELECT H.PK HPK  "& _
				"		, H.VOUCHERNO VOUCHER_NO  "& _
				"		, TO_CHAR(H.TR_DATE, 'YYYYMMDD') TR_DATE  "& _
				"		, SF_A_GET_REF_PL(D.PK) PL_NM  "& _
				"		, H.REMARK TR_REMARK  "& _
				"		, H.REMARK2 TR_REMARK2   "& _
				"		, decode((SUBSTR(SF_A_GET_ACCD(D.TAC_ABACCTCODE_PK),0,4 )),'1122', D.TR_AMT, 0) bank_usd "& _
				"		, decode((SUBSTR(SF_A_GET_ACCD(D.TAC_ABACCTCODE_PK),0,4 )),'1121', D.TR_AMT, 0) bank_vnd "& _     
				"		, decode((SUBSTR(SF_A_GET_ACCD(D.TAC_ABACCTCODE_PK),0,4 )),'1112', D.TR_AMT, 0) cash_usd "& _    
				"		, decode((SUBSTR(SF_A_GET_ACCD(D.TAC_ABACCTCODE_PK),0,4 )),'1111', D.TR_AMT, 0)cash_vnd	"& _	   
				"		, D.TR_BOOKAMT  bk_amt "& _
			"	   FROM TAC_BGTRH H, TAC_BGTRD D  "& _
			"	  WHERE H.DEL_IF = 0  "& _
			"		AND D.DEL_IF = 0  "& _
			"		AND H.PK = D.TAC_BGTRH_PK   "& _
			"		AND	H.TAC_ABTRTYPE_PK = 2086 "& _
			"		AND D.DRCR_TYPE = 'C' "& _		
			"		AND H.TCO_EOCOMPANY_PK LIKE DECODE('" & compk & "','','%%','" & compk & "')  "& _
			"		AND DECODE(NVL('' ,NULL),NULL,1,D.TCO_DCCUSTM_PK) = DECODE(NVL('',NULL),NULL,1,'') "& _
			"		AND TO_CHAR(H.TR_DATE, 'YYYYMMDD') BETWEEN  '" & sdt & "' AND  '" & edt & "' "& _
			"		AND (H.VOUCHERNO LIKE '%' || trim(UPPER('')) || '%' OR H.VOUCHERNO IS NULL)  "& _					
			"	  ORDER BY H.VOUCHERNO, D.PK	"
	If Not rs.EOF Then
		result 	= rs.GetRows()
		total 	= Ubound(result, 2) + 1
	else
		total = 0
	End If		
%>	
	<%
	
	 sum_bank_usd = 0
	 sum_bank_vnd = 0
	 sum_cash_usd = 0
	 sum_cash_vnd = 0
	 sum_bk_amt = 0
	 numPage = 0
	 If total > 0 Then
		For i=1 to total
			numPage = numPage + 1
			pay_date = result(2,i-1)
			pay_date = right(pay_date, 2) + "/" + mid(pay_date, 5,2) + "/" + left(pay_date,4)

			bank_usd = result(6,i-1)
			bank_vnd = result(7,i-1)
			cash_usd = result(8,i-1)
			cash_vnd = result(9,i-1)
			bk_amt = result(10,i-1)
			
			sum_bank_usd = CDbl(sum_bank_usd) + CDbl(bank_usd)
			sum_bank_vnd = CDbl(sum_bank_vnd) + CDbl(bank_vnd)
			
			sum_cash_usd = CDbl(sum_cash_usd) + CDbl(cash_usd)
			sum_cash_vnd = CDbl(sum_cash_vnd) + CDbl(cash_vnd)
			
			sum_bk_amt = CDbl(sum_bk_amt) + CDbl(bk_amt)
		 %>
		 <tr class=xl26 height=42 style='mso-height-source:userset;height:32.1pt'>
		  <td height=42 class=xl38 style='height:32.1pt;border-top:none' x:num><%=numPage%></td>
		  <td class=xl31 style='border-top:none;border-left:none' x:num><%=result(0,i-1)%></td>
		  <td class=xl41 style='border-top:none;border-left:none'><%=result(1,i-1)%></td>
		  <td class=xl42 style='border-top:none;border-left:none'><%=pay_date%></td>
		  <td class=xl32 width=334 style='border-top:none;border-left:none;width:251pt'		  ><%=result(4,i-1)%></td>
		  <td class=xl33 width=145 style='border-top:none;border-left:none;width:109pt' x:num=""></td>
		  <td class=xl34 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(6,i-1)%></td>
		  <td class=xl35 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(7,i-1)%></td>
		  <td class=xl34 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(8,i-1)%></td>
		  <td class=xl35 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(9,i-1)%></td>
		  <td class=xl34 align=right style='border-top:none;border-left:none'		  x:num=""><%=result(10,i-1)%></td>
		  <td class=xl34 style='border-top:none;border-left:none'></td>
		 </tr>
		
	  <% 
		Next
	 End If
	 %>
	 <% If total > 0 Then %>
	  <tr height=29 style='mso-height-source:userset;height:21.95pt'>
	  <td colspan=6 height=29 class=xl64 style='border-right:.5pt solid black;
	  height:21.95pt'>Grand Total</td>
	  <td class=xl43 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_bank_usd%></td>
	  <td class=xl67 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_bank_vnd%></td>
	  <td class=xl43 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_cash_usd%></td>
	  <td class=xl67 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_cash_vnd%></td>
	  <td class=xl43 align=right style='border-top:none;border-left:none'  x:num=""><%=sum_bk_amt%></td>
	  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
	 </tr>
	 <% End If%>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=334 style='width:251pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
