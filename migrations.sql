-- Agregasi server-side untuk dashboard EK Komisi.
-- Jalankan di Supabase Dashboard -> SQL Editor.
-- security_invoker=true agar RLS tetap berlaku untuk pemanggil view.

create or replace view period_stats
with (security_invoker = true) as
select
  period,
  min(period_sort_date) as period_sort_date,
  coalesce(sum(subtotal), 0) as total,
  coalesce(sum(case when payment_status = 'paid' then subtotal else 0 end), 0) as paid,
  coalesce(sum(case when payment_status = 'due'  then subtotal else 0 end), 0) as due
from commission_rows
group by period;

create or replace view sales_period_stats
with (security_invoker = true) as
select
  marketing_name,
  period,
  min(period_sort_date) as period_sort_date,
  coalesce(sum(subtotal), 0) as total,
  coalesce(sum(case when payment_status = 'paid' then subtotal else 0 end), 0) as paid,
  coalesce(sum(case when payment_status = 'due'  then subtotal else 0 end), 0) as due
from commission_rows
group by marketing_name, period;
