
 ### Решение на C
 
[solution.c](https://github.com/axhse/CSA-HW-1/blob/main/solution.c)  

 ### Компиляция

```
gcc solution.c -S -masm=intel -Wall -O0 -fno-asynchronous-unwind-tables -o solution.s
gcc solution.c -S -masm=intel -Wall -O0 -fno-asynchronous-unwind-tables -fcf-protection=none -o no_protection.s
```

[macro_hard_removed.s](https://github.com/axhse/CSA-HW-1/blob/main/macro_hard_removed.s)  -  копия [no_protection.s](https://github.com/axhse/CSA-HW-1/blob/main/no_protection.s), из которой вручную удалены некоторые макросы  
Основные удаленные вручную макросы: **.align** **.globl** **.size** **.type**  

```
gcc solution.s -masm=intel -Wall -O0 -fno-asynchronous-unwind-tables -fcf-protection=none -o solution.out
gcc no_protection.s -masm=intel -Wall -O0 -fno-asynchronous-unwind-tables -fcf-protection=none -o no_protection.out
gcc macro_hard_removed.s -masm=intel -Wall -O0 -fno-asynchronous-unwind-tables -fcf-protection=none -o macro_hard_removed.out
```

Все 3 полученные **.out** файлы были протестированы на одинаковых данных [test_data.txt](https://github.com/axhse/CSA-HW-1/blob/main/test_data.txt), результаты отображены в соответствующих **.png** файлах  

 ### Переменные

- Глобальные: **base_array**, **freaky_array**, **base_array_length**, **freaky_array_length**  
- Локальные по функциям:  
• **try_input_base_array**: **i**  
• **print_array**: **i**  
• **fill_freaky_array**: **first_positive_value_index**, **i**, **j**  

Комментарии по переменным добавлены в [solution.s](https://github.com/axhse/CSA-HW-1/blob/main/solution.s)  
Там же комментарии по параметрам (**array**, **length**) и возвращаемым значениям (из **main** и **try_input_base_array**)  

 ### Оптимизация
 
Компиляция оптимизированной версии (активнее используются регистры):  

```
gcc safe_solution.c -S -masm=intel -Wall -O3 -fno-asynchronous-unwind-tables -fcf-protection=none -o optimized.s
gcc optimized.s -masm=intel -Wall -O3 -fno-asynchronous-unwind-tables -fcf-protection=none -o optimized.out
```
[safe_solution.c](https://github.com/axhse/CSA-HW-1/blob/main/safe_solution.c) отличается только наличием проверок возвращаемого значения **scanf** и удалением избыточного зануления **freaky_array_length**)  

[optimized.s](https://github.com/axhse/CSA-HW-1/blob/main/optimized.s) содержит комментарии по дополнительному использованию регистров, а также некоторые разъяснения происходящего  
**optimized.out** также была протестирована ([optimized.png](https://github.com/axhse/CSA-HW-1/blob/main/optimized.png))  
