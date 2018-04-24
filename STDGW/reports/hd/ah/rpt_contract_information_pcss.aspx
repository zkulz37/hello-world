<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
string SQL1
	= "select c00    ,c01    ,c02    ,c03    ,c04    ,c05    ,c06    ,c07    ,c08    ,c09     " + 
        "        ,c10    ,c11    ,c12    ,c13    ,c14    ,c15    ,c16    ,c17    ,c18    ,c19     " +
        "        ,c20    ,c21    ,c22    ,c23    ,c24, c25 , c26  " +
        "from " +
        "(select E.EMP_ID c00, A.ORG_ID c01,  E.FULL_NAME c02 " +
        "    ,(select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and id='HR0008') c03   " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c04 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c05 " +
        "    ,  to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c06 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                || case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                            else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=2 ) c07 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=3 ) c08 " +
        "      , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=4 ) c09 " +
        "     , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=5 ) c10           " +
        "    , nvl( E.BASIC_SAL,0) " +
        "        +nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) c11 " +
        "    , nvl( E.BASIC_SAL,0) c12 " +
        "    , nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) c13      " +
        "    , nvl(E.ALLOW_AMT1,0) c14 " +
        "    , nvl(E.ALLOW_AMT2,0) c15 " +
        "    , nvl(E.ALLOW_AMT3,0) c16 " +
        "    , nvl(E.ALLOW_AMT4,0) c17 " +
        "    , nvl(E.ALLOW_AMT5,0) c18   " +
        //"    , (select V.CODE_KNM                " +
        //"        from thr_labour_contract b, vhr_hr_code v " +
        //"        where B.DEL_IF=0 and V.ID='HR0001' " +
        //"        and V.CODE=B.CONTRACT_TYPE " +
        //"        and E.CONTRACT_TIMES=B.CONTRACT_TIMES " +
        //"        and B.THR_EMPLOYEE_PK=e.pk " +
        //"         ) c19 " +
		"	 , case when e.CONTRACT_TIMES=1 then 'PROBATION CONTRACT' 	" +
		"			when e.CONTRACT_TIMES=2 then 'THE FIRST L/C'	" +
		"			when e.CONTRACT_TIMES=3 then 'THE SECOND L/C'	" +
		"			when e.CONTRACT_TIMES=4 then 'THE THIRD L/C'	" +
		"			when e.CONTRACT_TIMES=5 then 'THE FOURTH L/C'	" +
		"		end c19 " +
        "    , E.NATION c20 " +
        "    , (select substr(v.char_4,1,3) from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c21 " +
        "    , A.seq c22     " +
        "    , (select v.num_1 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c23         " +
        "    , E.JOIN_DT c24 " +
        "    , E.EMP_ID c25  " +
		"    , (select substr(v.char_4,5,length(v.char_4))  from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  c26  " +
        " from thr_employee e , tco_org a " +
        "where  E.DEL_IF=0 " +
        "and A.DEL_IF=0 " +
        "and E.STATUS='A' " +
        "and E.NATION='02' and nvl(E.MONEY_KIND,'01')='02' " +
        "and E.TCO_ORG_PK=a.pk " +
        ") " +
        "order by c20 desc, c21, c22,c23,c24, c25 " ; //nguoi nuoc ngoai 
		
		//Response.Write(SQL1);
        //Response.End();
        DataTable dt_emp_k = ESysLib.TableReadOpen(SQL1);
        if (dt_emp_k.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
		
		string SQL2
	= "select round(sum(nvl(c11,0)),0)   c11 ,round(sum(nvl(c12,0)),0)   c12 ,round(sum(nvl(c13,0)),0)  c13  ,round(sum(nvl(c14,0)),0)   c14 " + 
        "        ,round(sum(nvl(c15,0)),0)   c15 ,round(sum(nvl(c16,0)),0)    c16,round(sum(nvl(c17,0)),0)   c17 ,round(sum(nvl(c18,0)),0) c18 " +        
		"        ,round(sum(nvl(c11,0))/decode(sum(case when nvl(c11,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c11,0) > 0 then 1 else 0 end)) ,0)   c111 "+
		"		 ,round(sum(nvl(c12,0))/decode(sum(case when nvl(c12,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c12,0) > 0 then 1 else 0 end)),0)   c122 "+
		"		 ,round(sum(nvl(c13,0))/decode(sum(case when nvl(c13,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c13,0) > 0 then 1 else 0 end)),0)  c133  "+
		"		 ,round(sum(nvl(c14,0))/decode(sum(case when nvl(c14,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c14,0) > 0 then 1 else 0 end)),0)   c144 " +
        "        ,round(sum(nvl(c15,0))/decode(sum(case when nvl(c15,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c15,0) > 0 then 1 else 0 end)),0)   c155 "+
		"		 ,round(sum(nvl(c16,0))/decode(sum(case when nvl(c16,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c16,0) > 0 then 1 else 0 end)),0)    c166 "+
		"		 ,round(sum(nvl(c17,0))/decode(sum(case when nvl(c17,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c17,0) > 0 then 1 else 0 end)),0)   c177  "+
		"		 ,round(sum(nvl(c18,0))/decode(sum(case when nvl(c18,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c18,0) > 0 then 1 else 0 end)),0) c188 " +
        "from " +
        "(select E.EMP_ID c00, A.ORG_ID c01,  E.FULL_NAME c02 " +
        "    ,(select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and id='HR0008') c03   " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c04 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c05 " +
        "    ,  to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c06 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                || case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                            else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=2 ) c07 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=3 ) c08 " +
        "      , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=4 ) c09 " +
        "     , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=5 ) c10           " +
        "    , nvl( E.BASIC_SAL,0) " +
        "        +nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) c11 " +
        "    , nvl( E.BASIC_SAL,0) c12 " +
        "    , nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) c13      " +
        "    , nvl(E.ALLOW_AMT1,0) c14 " +
        "    , nvl(E.ALLOW_AMT2,0) c15 " +
        "    , nvl(E.ALLOW_AMT3,0) c16 " +
        "    , nvl(E.ALLOW_AMT4,0) c17 " +
        "    , nvl(E.ALLOW_AMT5,0) c18   " +
        "    , (select V.CODE_KNM                " +
        "        from thr_labour_contract b, vhr_hr_code v " +
        "        where B.DEL_IF=0 and V.ID='HR0001' " +
        "        and V.CODE=B.CONTRACT_TYPE " +
        "        and E.CONTRACT_TIMES=B.CONTRACT_TIMES " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "         ) c19 " +
        "    , E.NATION c20 " +
        "    , (select substr(v.char_4,1,3) from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c21 " +
        "    , A.seq c22     " +
        "    , (select v.num_1 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c23         " +
        "    , E.JOIN_DT c24 " +
        "    , E.EMP_ID c25  " +
		"    , (select substr(v.char_4,5,length(v.char_4))  from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  c26  " +
        "from thr_employee e , tco_org a " +
        "where  E.DEL_IF=0 " +
        "and A.DEL_IF=0 " +
        "and E.STATUS='A' " +
        "and E.NATION='02' and nvl(E.MONEY_KIND,'01')='02' " +
        "and E.TCO_ORG_PK=a.pk " +
        ") " ;
		
		//Response.Write(SQL2);
        //Response.End();
		
		DataTable dt_tt_emp_k = ESysLib.TableReadOpen(SQL2);
        if (dt_tt_emp_k.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
		
		string SQL3
	= "select count(*) c00 " +
        "from " +
        "(select E.EMP_ID c00, A.ORG_ID c01,  E.FULL_NAME c02 " +
        "    ,(select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and id='HR0008') c03   " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c04 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c05 " +
        "    ,  to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c06 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                || case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                            else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=2 ) c07 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=3 ) c08 " +
        "      , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=4 ) c09 " +
        "     , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=5 ) c10           " +
        "    , nvl( E.BASIC_SAL,0) " +
        "        +nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) c11 " +
        "    , nvl( E.BASIC_SAL,0) c12 " +
        "    , nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) c13      " +
        "    , nvl(E.ALLOW_AMT1,0) c14 " +
        "    , nvl(E.ALLOW_AMT2,0) c15 " +
        "    , nvl(E.ALLOW_AMT3,0) c16 " +
        "    , nvl(E.ALLOW_AMT4,0) c17 " +
        "    , nvl(E.ALLOW_AMT5,0) c18   " +
        "    , (select V.CODE_KNM                " +
        "        from thr_labour_contract b, vhr_hr_code v " +
        "        where B.DEL_IF=0 and V.ID='HR0001' " +
        "        and V.CODE=B.CONTRACT_TYPE " +
        "        and E.CONTRACT_TIMES=B.CONTRACT_TIMES " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "         ) c19 " +
        "    , E.NATION c20 " +
        "    , (select substr(v.char_4,1,3) from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c21 " +
        "    , A.seq c22     " +
        "    , (select v.num_1 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c23         " +
        "    , E.JOIN_DT c24 " +
        "    , E.EMP_ID c25  " +
		"    , (select substr(v.char_4,5,length(v.char_4))  from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  c26  " +
        "from thr_employee e , tco_org a " +
        "where  E.DEL_IF=0 " +
        "and A.DEL_IF=0 " +
        "and E.STATUS='A' " +
        "and E.NATION='02' and nvl(E.MONEY_KIND,'01')='02' " +
        "and E.TCO_ORG_PK=a.pk " +
        ") " +
		" GROUP BY c20, c21, c22 order by c20, c21, c22  " ;
		
		//Response.Write(SQL3);
        //Response.End();
		
		DataTable dt_cnt_emp_k = ESysLib.TableReadOpen(SQL3);
		
		string SQL4
	= "select c00    ,c01    ,c02    ,c03    ,c04    ,c05    ,c06    ,c07    ,c08    ,c09     " + 
        "        ,c10    ,c11/1000 c11    ,c12/1000 c12   ,c13/1000 c13   ,c14/1000  c14  ,c15/1000  c15  ,c16/1000  c16  ,c17/1000  c17  ,c18/1000  c18  ,c19     " +
        "        ,c20    ,c21    ,c22    ,c23    ,c24, c25 , c26  " +
        "from " +
        "(select E.EMP_ID c00, A.ORG_ID c01,  E.FULL_NAME c02 " +
        "    ,(select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and id='HR0008') c03   " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c04 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c05 " +
        "    ,  to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c06 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                || case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                            else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=2 ) c07 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=3 ) c08 " +
        "      , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=4 ) c09 " +
        "     , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=5 ) c10           " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) " +
        "        +nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c11 " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) end c12 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c13      " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) end c14 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT2,0) end c15 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT3,0) end c16 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT4,0) end c17 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT5,0) end c18   " +
        //"    , (select V.CODE_KNM                " +
        //"        from thr_labour_contract b, vhr_hr_code v " +
        //"        where B.DEL_IF=0 and V.ID='HR0001' " +
        //"        and V.CODE=B.CONTRACT_TYPE " +
        //"        and E.CONTRACT_TIMES=B.CONTRACT_TIMES " +
        //"        and B.THR_EMPLOYEE_PK=e.pk " +
        //"         ) c19 " +
		"	 , case when e.CONTRACT_TIMES=1 then 'PROBATION CONTRACT' 	" +
		"			when e.CONTRACT_TIMES=2 then 'THE FIRST L/C'	" +
		"			when e.CONTRACT_TIMES=3 then 'THE SECOND L/C'	" +
		"			when e.CONTRACT_TIMES=4 then 'THE THIRD L/C'	" +
		"			when e.CONTRACT_TIMES=5 then 'THE FOURTH L/C'	" +
		"		end c19 " +
        "    , E.NATION c20 " +
        "    , (select substr(v.char_4,1,3) from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c21 " +
        "    , A.seq c22     " +
        "    , (select v.num_1 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c23         " +
        "    , E.JOIN_DT c24 " +
        "    , E.EMP_ID c25  " +
		"    , (select substr(v.char_4,5,length(v.char_4))  from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  c26  " +
        " from thr_employee e , tco_org a " +
        "where  E.DEL_IF=0 " +
        "and A.DEL_IF=0 " +
        "and E.STATUS='A' " +
        "and E.NATION='01' " +
        "and E.TCO_ORG_PK=a.pk " +
        ") " +
        "order by c20 desc, c21, c22,c23,c24, c25 " ; //nguoi vn
		
		//Response.Write(SQL4);
        //Response.End();
        DataTable dt_emp_v = ESysLib.TableReadOpen(SQL4);
        if (dt_emp_k.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
		
		string SQL5
	= "select round(sum(nvl(c11,0))/1000,0)   c11 ,round(sum(nvl(c12,0))/1000,0)   c12 ,round(sum(nvl(c13,0))/1000,0)  c13  ,round(sum(nvl(c14,0))/1000,0)   c14 " + 
        "        ,round(sum(nvl(c15,0))/1000,0)   c15 ,round(sum(nvl(c16,0))/1000,0)    c16,round(sum(nvl(c17,0))/1000,0)   c17 ,round(sum(nvl(c18,0))/1000,0) c18 " +
        //"        ,round(avg(nvl(c11,0))/1000,0)   c111 ,round(avg(nvl(c12,0))/1000,0)   c122 ,round(avg(nvl(c13,0))/1000,0)  c133  ,round(avg(nvl(c14,0))/1000,0)   c144 " +
        //"        ,round(avg(nvl(c15,0))/1000,0)   c155 ,round(avg(nvl(c16,0))/1000,0)    c166,round(avg(nvl(c17,0))/1000,0)   c177 ,round(avg(nvl(c18,0))/1000,0) c188 " +
	"   ,round(sum(nvl(c11,0))/1000/decode(sum(case when nvl(c11,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c11,0) > 0 then 1 else 0 end)),0)   c111 "+
	"	,round(sum(nvl(c12,0))/1000/decode(sum(case when nvl(c12,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c12,0) > 0 then 1 else 0 end)),0)   c122 "+
	"	,round(sum(nvl(c13,0))/1000/decode(sum(case when nvl(c13,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c13,0) > 0 then 1 else 0 end)),0)  c133  "+
	"	,round(sum(nvl(c14,0))/1000/decode(sum(case when nvl(c14,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c14,0) > 0 then 1 else 0 end)),0)   c144 " +
	"   ,round(sum(nvl(c15,0))/1000/decode(sum(case when nvl(c15,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c15,0) > 0 then 1 else 0 end)),0)   c155 "+
	"	,round(sum(nvl(c16,0))/1000/decode(sum(case when nvl(c16,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c16,0) > 0 then 1 else 0 end)),0)    c166"+
	"	,round(sum(nvl(c17,0))/1000/decode(sum(case when nvl(c17,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c17,0) > 0 then 1 else 0 end)),0)   c177 "+
	"	,round(sum(nvl(c18,0))/1000/decode(sum(case when nvl(c18,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c18,0) > 0 then 1 else 0 end)),0) c188 " +
		"		 , count(*) c27	" +
        "from " +
        "(select E.EMP_ID c00, A.ORG_ID c01,  E.FULL_NAME c02 " +
        "    ,(select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and id='HR0008') c03   " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c04 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c05 " +
        "    ,  to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c06 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                || case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                            else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=2 ) c07 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=3 ) c08 " +
        "      , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=4 ) c09 " +
        "     , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=5 ) c10           " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) " +
        "        +nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c11 " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) end c12 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c13      " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) end c14 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT2,0) end c15 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT3,0) end c16 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT4,0) end c17 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT5,0) end c18   " +
        "    , (select V.CODE_KNM                " +
        "        from thr_labour_contract b, vhr_hr_code v " +
        "        where B.DEL_IF=0 and V.ID='HR0001' " +
        "        and V.CODE=B.CONTRACT_TYPE " +
        "        and E.CONTRACT_TIMES=B.CONTRACT_TIMES " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "         ) c19 " +
        "    , E.NATION c20 " +
        "    , (select substr(v.char_4,1,3) from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c21 " +
        "    , A.seq c22     " +
        "    , (select v.num_1 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c23         " +
        "    , E.JOIN_DT c24 " +
        "    , E.EMP_ID c25  " +
		"    , (select substr(v.char_4,5,length(v.char_4))  from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  c26  " +
        "from thr_employee e , tco_org a " +
        "where  E.DEL_IF=0 " +
        "and A.DEL_IF=0 " +
        "and E.STATUS='A' " +
        "and E.NATION='01' " +
        "and E.TCO_ORG_PK=a.pk " +
        ") " ;//sum total vn
		
		//Response.Write(SQL5);
        //Response.End();
		
		DataTable dt_tt_emp_v = ESysLib.TableReadOpen(SQL5);
        if (dt_tt_emp_k.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
		
		string SQL6
	= "select count(*) c00 " +
        "from " +
        "(select E.EMP_ID c00, A.ORG_ID c01,  E.FULL_NAME c02 " +
        "    ,(select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and id='HR0008') c03   " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c04 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c05 " +
        "    ,  to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c06 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                || case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                            else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=2 ) c07 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=3 ) c08 " +
        "      , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=4 ) c09 " +
        "     , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=5 ) c10           " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) " +
        "        +nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c11 " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) end c12 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c13      " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) end c14 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT2,0) end c15 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT3,0) end c16 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT4,0) end c17 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT5,0) end c18   " +
        "    , (select V.CODE_KNM                " +
        "        from thr_labour_contract b, vhr_hr_code v " +
        "        where B.DEL_IF=0 and V.ID='HR0001' " +
        "        and V.CODE=B.CONTRACT_TYPE " +
        "        and E.CONTRACT_TIMES=B.CONTRACT_TIMES " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "         ) c19 " +
        "    , E.NATION c20 " +
        "    , (select substr(v.char_4,1,3) from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c21 " +
        "    , A.seq c22     " +
        "    , (select v.num_1 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c23         " +
        "    , E.JOIN_DT c24 " +
        "    , E.EMP_ID c25  " +
		"    , (select substr(v.char_4,5,length(v.char_4))  from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  c26  " +
        "from thr_employee e , tco_org a " +
        "where  E.DEL_IF=0 " +
        "and A.DEL_IF=0 " +
        "and E.STATUS='A' " +
        "and E.NATION='01' " +
        "and E.TCO_ORG_PK=a.pk " +
        ") " +
		" GROUP BY c20, c21, c22 order by c20, c21, c22  " ;
		
		//Response.Write(SQL6);
        //Response.End();
		
		DataTable dt_cnt_emp_v = ESysLib.TableReadOpen(SQL6);
		
		string SQL7
	= "select round(sum(nvl(c11,0))/1000,0)   c11 ,round(sum(nvl(c12,0))/1000,0)   c12 ,round(sum(nvl(c13,0))/1000,0)  c13  ,round(sum(nvl(c14,0))/1000,0)   c14 " + 
        "        ,round(sum(nvl(c15,0))/1000,0)   c15 ,round(sum(nvl(c16,0))/1000,0)    c16,round(sum(nvl(c17,0))/1000,0)   c17 ,round(sum(nvl(c18,0))/1000,0) c18 " +
        //"        ,round(avg(nvl(c11,0))/1000,0)   c111 ,round(avg(nvl(c12,0))/1000,0)   c122 ,round(avg(nvl(c13,0))/1000,0)  c133  ,round(avg(nvl(c14,0))/1000,0)   c144 " +
        //"        ,round(avg(nvl(c15,0))/1000,0)   c155 ,round(avg(nvl(c16,0))/1000,0)    c166,round(avg(nvl(c17,0))/1000,0)   c177 ,round(avg(nvl(c18,0))/1000,0) c188 " +
		"        ,round(sum(nvl(c11,0))/1000/decode(sum(case when nvl(c11,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c11,0) > 0 then 1 else 0 end)),0)   c111 "+
		"        ,round(sum(nvl(c12,0))/1000/decode(sum(case when nvl(c12,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c12,0) > 0 then 1 else 0 end)),0)   c122 "+
		"        ,round(sum(nvl(c13,0))/1000/decode(sum(case when nvl(c13,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c13,0) > 0 then 1 else 0 end)),0)  c133  "+
		"        ,round(sum(nvl(c14,0))/1000/decode(sum(case when nvl(c14,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c14,0) > 0 then 1 else 0 end)),0)   c144 " +
        "        ,round(sum(nvl(c15,0))/1000/decode(sum(case when nvl(c15,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c15,0) > 0 then 1 else 0 end)),0)   c155 "+
		"        ,round(sum(nvl(c16,0))/1000/decode(sum(case when nvl(c16,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c16,0) > 0 then 1 else 0 end)),0)    c166"+
		"        ,round(sum(nvl(c17,0))/1000/decode(sum(case when nvl(c17,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c17,0) > 0 then 1 else 0 end)),0)   c177 "+
		"        ,round(sum(nvl(c18,0))/1000/decode(sum(case when nvl(c18,0) > 0 then 1 else 0 end),0,1,sum(case when nvl(c18,0) > 0 then 1 else 0 end)),0) c188 " +
		"		 , c26 , count(*) c27	" +
        "from " +
        "(select E.EMP_ID c00, A.ORG_ID c01,  E.FULL_NAME c02 " +
        "    ,(select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE and id='HR0008') c03   " +
        "    , decode(length(E.BIRTH_DT),4,E.BIRTH_DT, to_char(to_date(E.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) c04 " +
        "    , to_number(to_char(sysdate,'yyyy'))-to_number(  substr(E.BIRTH_DT,1,4)) c05 " +
        "    ,  to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c06 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                || case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                            else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=2 ) c07 " +
        "    , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=3 ) c08 " +
        "      , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=4 ) c09 " +
        "     , (select to_char(to_date(B.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                ||case when B.CONTRACT_TYPE<> '04' then  '~'|| " +
        "                            to_char(to_date(B.END_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') " +
        "                else " +
        "                            '' " +
        "                    end " +
        "        from thr_labour_contract b " +
        "        where B.DEL_IF=0 " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "        and B.CONTRACT_TIMES=5 ) c10           " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) " +
        "        +nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c11 " +
        "    , case when e.CONTRACT_TIMES=1 then nvl(PRO_SAL,0) else nvl( E.BASIC_SAL,0) end c12 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) " +
        "        +nvl(E.ALLOW_AMT2,0) " +
        "        +nvl(E.ALLOW_AMT3,0) " +
        "        +nvl(E.ALLOW_AMT4,0) " +
        "        +nvl(E.ALLOW_AMT5,0) end c13      " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT1,0) end c14 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT2,0) end c15 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT3,0) end c16 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT4,0) end c17 " +
        "    , case when e.CONTRACT_TIMES=1 then 0 else nvl(E.ALLOW_AMT5,0) end c18   " +
        "    , (select V.CODE_KNM                " +
        "        from thr_labour_contract b, vhr_hr_code v " +
        "        where B.DEL_IF=0 and V.ID='HR0001' " +
        "        and V.CODE=B.CONTRACT_TYPE " +
        "        and E.CONTRACT_TIMES=B.CONTRACT_TIMES " +
        "        and B.THR_EMPLOYEE_PK=e.pk " +
        "         ) c19 " +
        "    , E.NATION c20 " +
        "    , (select substr(v.char_4,1,3) from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c21 " +
        "    , A.seq c22     " +
        "    , (select v.num_1 from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE ) c23         " +
        "    , E.JOIN_DT c24 " +
        "    , E.EMP_ID c25  " +
		"    , (select substr(v.char_4,5,length(v.char_4))  from vhr_hr_code v where v.id='HR0008' and v.code=E.POS_TYPE )  c26  " +
        "from thr_employee e , tco_org a " +
        "where  E.DEL_IF=0 " +
        "and A.DEL_IF=0 " +
        "and E.STATUS='A' " +
        "and E.NATION='01' " +
        "and E.TCO_ORG_PK=a.pk " +
        ") " + //sum group vn
		" group by c21,c26    order by c21,c26 " ;
		
		//Response.Write(SQL7);
        //Response.End();
		
		DataTable dt_grp_tt_emp_v = ESysLib.TableReadOpen(SQL7);
        if (dt_tt_emp_k.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_contract_infomation_pcss_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_contract_infomation_pcss_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_contract_infomation_pcss_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>SV108</o:LastAuthor>
  <o:Created>2013-02-21T01:57:56Z</o:Created>
  <o:LastSaved>2013-03-08T03:03:21Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
.style58
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
.xl65
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl74
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl75
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl76
	{mso-style-parent:style43;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl77
	{mso-style-parent:style58;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;}
.xl79
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl82
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl83
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:silver;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:silver;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl96
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
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl109
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl111
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl119
	{mso-style-parent:style0;
	color:blue;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl120
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl127
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
	background:silver;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl130
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl132
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl133
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl134
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl135
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>21-01-2013 </x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:FitWidth>0</x:FitWidth>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>20</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>115</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:RangeSelection>$A$4:$A$6</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7110</x:WindowHeight>
  <x:WindowWidth>18735</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='21-01-2013 '!$A$1:$V$15</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2162 style='border-collapse:
 collapse;table-layout:fixed;width:1625pt'>
 <col class=xl66 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl66 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl67 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl68 width=212 style='mso-width-source:userset;mso-width-alt:7753;
 width:159pt'>
 <col class=xl69 width=132 style='mso-width-source:userset;mso-width-alt:4827;
 width:99pt'>
 <col class=xl70 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl71 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl70 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl70 width=145 span=3 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl70 width=145 span=1 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt;display:none'>
 <col class=xl72 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl73 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl73  width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl74 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl74 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl74 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl74 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl74 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl68 width=177 style='mso-width-source:userset;mso-width-alt:6473;
 width:133pt'>
 <col class=xl65 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <tr height=40 style='height:30.0pt'>
  <td colspan=15 height=40 class=xl110 width=1431 style='height:30.0pt;
  width:1075pt'><a name="Print_Area"><span
  style='mso-spacerun:yes'>             </span>Labor Contract information</a></td>
  <td class=xl65 width=63 style='width:47pt'></td>
  <td colspan=5 class=xl111 width=387 style='width:290pt'><span
  style='mso-spacerun:yes'>           </span>Update: 21/01/2013</td>
  <td class=xl66 width=65 style='width:49pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl67 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl69></td>
  <td class=xl70></td>
  <td class=xl71></td>
  <td class=xl72></td>
  <td colspan=5 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl119></td>
  <td class=xl75></td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl77 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>Unit: 1,000 VND</td>
  <td class=xl78></td>
  <td class=xl66></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=2 class=xl79 style='height:5.25pt;mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl69></td>
  <td class=xl70></td>
  <td class=xl71></td>
  <td class=xl72></td>
  <td colspan=5 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl73></td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl75 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td class=xl66></td>
 </tr>
 <tr class=xl81 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td rowspan=3 height=69 class=xl112 style='height:51.75pt'>No.</td>
  <td rowspan=3 class=xl113 width=53 style='width:40pt'>Code<br>
    <span style='mso-spacerun:yes'> </span>Emp.</td>
  <td rowspan=3 class=xl114 width=58 style='width:44pt' x:str="Dept"><span
  style='mso-spacerun:yes'> </span>Dept<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl100 x:str="Name"><span
  style='mso-spacerun:yes'> </span>Name<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl116 x:str="Position"><span
  style='mso-spacerun:yes'> </span>Position<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl117 width=76 style='width:57pt' x:str="Date&#10; of birth"><span
  style='mso-spacerun:yes'> </span>Date<br>
    <span style='mso-spacerun:yes'> </span>of birth<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl100 x:str="Age"><span
  style='mso-spacerun:yes'> </span>Age<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl100 x:str="Start date"><span
  style='mso-spacerun:yes'> </span>Start date<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl101 width=151 style='border-bottom:.5pt solid black;
  width:113pt' x:str="First &#10;labor contract"><span
  style='mso-spacerun:yes'> </span>First <br>
    labor contract<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl101 width=141 style='border-bottom:.5pt solid black;
  width:106pt' x:str="Second &#10;labor contract"><span
  style='mso-spacerun:yes'> </span>Second <br>
    labor contract<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl101 width=141 style='border-bottom:.5pt solid black;
  width:106pt' x:str="Third&#10;labor contract"><span
  style='mso-spacerun:yes'> </span>Third<br>
    labor contract<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl101 width=141 style='border-bottom:.5pt solid black;
  width:106pt' x:str="Forth&#10;labor contract"><span
  style='mso-spacerun:yes'> </span>Forth<br>
    labor contract<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl124 width=66 style='width:50pt'>Total <br>
    standard<br>
    <span style='mso-spacerun:yes'> </span>salary</td>
  <td colspan=7 class=xl104 style='border-right:.5pt solid black;border-left:
  none'>Composition of the Salary</td>
  <td rowspan=3 class=xl107 width=124 style='border-bottom:.5pt solid black;
  width:93pt' x:str="Remark"><span style='mso-spacerun:yes'> </span>Remark<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl107 width=65 style='width:49pt' x:str="Total"><span
  style='mso-spacerun:yes'> </span>Total<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl81 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td rowspan=2 height=51 class=xl132 style='height:38.25pt;border-top:none'
  x:str="Basic"><span style='mso-spacerun:yes'> </span>Basic<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl133 style='border-right:.5pt solid black;border-left:
  none' x:str="Allowance"><span style='mso-spacerun:yes'> </span>Allowance<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl81 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl82 width=75 style='height:24.75pt;border-top:none;
  border-left:none;width:56pt' x:str="Total&#10;allowance"><span
  style='mso-spacerun:yes'> </span>Total<br>
    allowance<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Position"><span
  style='mso-spacerun:yes'> </span>Position<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Language"><span
  style='mso-spacerun:yes'> </span>Language<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Gasoline"><span
  style='mso-spacerun:yes'> </span>Gasoline<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Dilligence"><span
  style='mso-spacerun:yes'> </span>Dilligence<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="House"><span
  style='mso-spacerun:yes'> </span>House<span style='mso-spacerun:yes'> </span></td>
  <td class=xl84 style='border-left:none' x:num><%= int.Parse(dt_tt_emp_v.Rows[0]["c27"].ToString())+dt_emp_k.Rows.Count %></td>
 </tr>
 <tr class=xl86 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl84 style='height:14.25pt;border-top:none'>A.</td>
  <td colspan=11 class=xl120 style='border-left:none' x:str="KOREAN - USD"><span
  style='mso-spacerun:yes'> </span>KOREAN - USD<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl85 style='border-top:none' x:num><%=dt_tt_emp_k.Rows[0]["c11"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c12"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c13"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c14"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c15"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c16"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c17"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c18"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
  <td rowspan="<%=dt_emp_k.Rows.Count+2%>" class=xl84 style='border-bottom:1.0pt solid black;border-top:
  none' x:num><%=dt_emp_k.Rows.Count%></td>
 </tr>
 </tr>
 <%
	int k;
	int kj=0;
	int kflag=0;
	for(k=0;k<dt_emp_k.Rows.Count;k++)
	{
		if(k==0)
			kflag=1;
		else if(dt_emp_k.Rows[k]["c01"].ToString()!=dt_emp_k.Rows[k-1]["c01"].ToString())
			kflag=1;
		else 
			kflag=0;
		
 %>
 <tr class=xl93 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl87 style='height:14.25pt;border-top:none' x:num><%=k+1%></td>
  <td class=xl87 style='border-top:none;border-left:none' x:str><%=dt_emp_k.Rows[k]["c00"].ToString()%></td>
  <%
	if(kflag==1)
	{
  %>  
  <td class=xl87 rowspan="<%=dt_cnt_emp_k.Rows[kj++]["c00"]%>" style='border-top:none;border-left:none' x:str><%=dt_emp_k.Rows[k]["c01"].ToString()%></td>
  <%
	}
  %>
  
  
  <td class=xl98 style='border-top:none;border-left:none' x:str><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c02"].ToString()%><span
  style='mso-spacerun:yes'></span></td>
  <td class=xl89 width=120 style='border-top:none;border-left:none;width:90pt;white-space:nowrap;mso-text-control:shrinktofit;'
  x:str><span style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c03"].ToString()%><span style='mso-spacerun:yes'></span></td>
  <td class=xl90 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_k.Rows[k]["c04"].ToString()%></td>
  <td class=xl91 width=39 style='border-top:none;border-left:none;width:29pt' x:num><%=dt_emp_k.Rows[k]["c05"].ToString()%></td>
  <td class=xl90 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_k.Rows[k]["c06"].ToString()%></td>
  <td class=xl92 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_k.Rows[k]["c07"].ToString()%></td>
  <td class=xl92 style='border-top:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_k.Rows[k]["c08"].ToString()%></td>
  <td class=xl92 style='border-top:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_k.Rows[k]["c09"].ToString()%></td>
  <td class=xl92 style='border-top:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_k.Rows[k]["c10"].ToString()%></td>
  <td class=xl85 style='border-top:none' x:num><%=dt_emp_k.Rows[k]["c11"].ToString()%><span
  style='mso-spacerun:yes'></span></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c12"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c13"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c14"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c15"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c16"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c17"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c18"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' ><span
  style='mso-spacerun:yes'></span><%=dt_emp_k.Rows[k]["c19"].ToString()%></td>
 </tr>
 <%
 }
 %>
 <tr class=xl94 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=12 height=19 class=xl99 style='height:14.25pt' x:str="Average:"><span
  style='mso-spacerun:yes'> </span>Average:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl85 style='border-top:none' x:num><%=dt_tt_emp_k.Rows[0]["c111"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c122"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c133"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c144"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c155"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c166"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c177"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_k.Rows[0]["c188"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
 </tr>
 
 
 <tr class=xl86 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl95 style='height:14.25pt'>B.</td>
  <td colspan=11 class=xl118 style='border-left:none'
  x:str="VIETNAMESE - ( Unit: 1,000 VND)"><span
  style='mso-spacerun:yes'> </span>VIETNAMESE - ( Unit: 1,000 VND)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c11"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c12"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c13"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c14"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c15"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c16"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c17"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c18"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
  <td class=xl96 style='border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c27"].ToString()%></td>
 </tr> 
<%
	int v=0 ;
	string [] _pos=new string[]{"I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XIII","XIV","XV"};
	int vflag1=0, vflag2=0;
	int vj1=0, vj2=0;
	int seq=1;
	for(v=0; v<dt_emp_v.Rows.Count;v++)
	{
		if(v==0)
		{
			vflag1=1;
		}
		else if ( dt_emp_v.Rows[v]["c26"].ToString()!=dt_emp_v.Rows[v-1]["c26"].ToString() )		
		{
			vflag1=1;
		}
		else
		{
			vflag1=0;
		}
		if(v==0)
		{
			vflag2=1;
		}
		else if( dt_emp_v.Rows[v]["c01"].ToString()!=dt_emp_v.Rows[v-1]["c01"].ToString()
				||
				dt_emp_v.Rows[v]["c26"].ToString()!=dt_emp_v.Rows[v-1]["c26"].ToString()
				)	
		{
			vflag2=1;
		}
		else
		{
			vflag2=0;
		}
		
 %>
 <%
	if(vflag1==1)
	{
 %>
 <tr class=xl86 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl84 style='height:14.25pt;border-top:none'><%=_pos[vj1]%>.</td>
  <td colspan=11 class=xl126 style='border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=dt_grp_tt_emp_v.Rows[vj1]["c26"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c11"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c12"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c13"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c14"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c15"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c16"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c17"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_grp_tt_emp_v.Rows[vj1]["c18"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
  <td rowspan="<%=int.Parse(dt_grp_tt_emp_v.Rows[vj1]["c27"].ToString())+2%>" class=xl127 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%=int.Parse(dt_grp_tt_emp_v.Rows[vj1]["c27"].ToString())%></td>
 </tr>
 <%
	}
 %>
 <tr class=xl93 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl87 style='height:14.25pt;border-top:none' x:num><%=seq++%></td>
  <td class=xl87 style='border-top:none;border-left:none' x:str><%=dt_emp_v.Rows[v]["c00"].ToString()%></td>
  <%
	if(vflag2==1)
  {
  %>
  <td rowspan="<%=dt_cnt_emp_v.Rows[vj2++]["c00"].ToString()%>" class=xl129 style='border-top:none' x:str><%=dt_emp_v.Rows[v]["c01"].ToString()%></td>
  <%
	}
  %>
  <td class=xl98 style='border-top:none;border-left:none' x:str><%=dt_emp_v.Rows[v]["c02"].ToString()%></td>
  <td class=xl89 width=120 style='border-top:none;border-left:none;width:90pt;white-space:nowrap;mso-text-control:shrinktofit;' x:str><%=dt_emp_v.Rows[v]["c03"].ToString()%></td>
  <td class=xl90 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_v.Rows[v]["c04"].ToString()%></td>
  <td class=xl91 width=39 style='border-top:none;border-left:none;width:29pt'><%=dt_emp_v.Rows[v]["c05"].ToString()%></td>
  <td class=xl90 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_v.Rows[v]["c06"].ToString()%></td>
  <td class=xl92 style='border-top:none;border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_v.Rows[v]["c07"].ToString()%></td>
  <td class=xl92 style='border-top:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_v.Rows[v]["c08"].ToString()%></td>
  <td class=xl92 style='border-top:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_v.Rows[v]["c09"].ToString()%></td>
  <td class=xl92 style='border-top:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_emp_v.Rows[v]["c10"].ToString()%></td>
  <td class=xl85 style='border-top:none' x:num><%=dt_emp_v.Rows[v]["c11"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c12"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c13"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c14"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c15"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c16"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c17"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c18"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_emp_v.Rows[v]["c19"].ToString()%></td>
 </tr>
 <%
	if(v==dt_emp_v.Rows.Count-1)
	{
		vflag1=1;		
	}
	else if(dt_emp_v.Rows[v]["c26"].ToString()!=dt_emp_v.Rows[v+1]["c26"].ToString())
	{
		vflag1=1;
		seq=1;
	}
	else 
		vflag1=0;
 %>
 
 <%
	if(vflag1==1)
	{
 %>
 <tr class=xl94 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=12 height=19 class=xl130 style='height:14.25pt'
  x:str><span style='mso-spacerun:yes'> </span>Sub average <%=dt_grp_tt_emp_v.Rows[vj1]["c26"].ToString()%>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl85 style='border-top:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1]["c111"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1]["c122"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1]["c133"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1]["c144"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1]["c155"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1]["c166"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1]["c177"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%=dt_grp_tt_emp_v.Rows[vj1++]["c188"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
 </tr> 
 
 <%
	}
 %>
 
 <%
	} //end for
 %>
 <tr class=xl94 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=12 height=19 class=xl130 style='height:14.25pt'
  x:str="Grand Average:"><span style='mso-spacerun:yes'> </span>Grand
  Average:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl85 style='border-top:none' x:num><%=dt_tt_emp_v.Rows[0]["c111"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c122"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c133"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c144"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c155"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c166"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c177"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt_tt_emp_v.Rows[0]["c188"].ToString()%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num></td>
  <td class=xl97 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr> 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>

 </tr>
 <![endif]>
</table>

</body>

</html>
