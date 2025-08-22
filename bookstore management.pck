create or replace noneditionable package bookstore is

  procedure insert_kitob(id1         number,
                         kitob_nomi  varchar2,
                         muallif     varchar2,
                         kitob_janri varchar2,
                         kitob_narxi number);
  procedure register_users(i_id           number,
                           i_name         varchar2,
                           i_last_name    varchar2,
                           i_phone_number varchar2);
  
  procedure price_upg(id1 number, last_narxi number);
  function is_have(janr varchar2) return varchar2;

end bookstore;
/
create or replace noneditionable package body bookstore is

  procedure insert_kitob(id1         number,
                         kitob_nomi  varchar2,
                         muallif     varchar2,
                         kitob_janri varchar2,
                         kitob_narxi number) is
  begin
    insert into kitoblar
      (id, kitob_nomi, muallif, kitob_janri, narxi)
    values
      (id1, kitob_nomi, muallif, kitob_janri, kitob_narxi);
    commit;
  end insert_kitob;
  -------------------------------------------------------------------------------- 
  procedure register_users(i_id           number,
                           i_name         varchar2,
                           i_last_name    varchar2,
                           i_phone_number varchar2) is
  begin
    insert into book_users
      (user_id, user_name, user_last_name, user_phone_number)
    values
      (i_id, i_name, i_last_name, i_phone_number);
    commit;
  end register_users;
  -------------------------------------------------------------------------------- 
  procedure price_upg(id1 number, last_narxi number) is
  begin
    update kitoblar
       set kitoblar.narxi = last_narxi
     where kitoblar.id = id1;
    if sql%rowcount = 0 then
      dbms_output.put_line('amaliyot bajarilmadi');
    else
      dbms_output.put_line('amaliyot muvaffaqiyatli bajarildi');
    end if;
    commit;
  end price_upg;
  -------------------------------------------------------------------------------- 

  function is_have(janr varchar2) return varchar2 is
    v_count number;
  begin
    select COUNT(*)
      into v_count
      from kitoblar k
     where UPPER(k.kitob_janri) = UPPER(janr);
    if v_count = 0 then
      return 'bunday janr yoq';
    else
      return 'bunday janr bor';
    end if;
  
  end is_have;

end bookstore;
/
