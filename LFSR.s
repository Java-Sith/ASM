#Todas las funciones utilizadas en este script fueron obtenidas del User Manual de RISC-V

start:
     #ASCII de la letra S en Hex: 83 = 0x53
    li a1, 0x53
    #Se pude escribir el valor semilla en la posición 100
    li a2, 0x100 
    #Se debe guardar nada más el byte 0 usando store word
    sw a1, 0(a2)
    #Contador para llevar control de las iteraciones
    li a3, 0x00
    #
    li a4, 0x64

lsfr:
    #Se extrae el bit en la posición 8 con rotación para colocarlo como LSB
    srli t0, a1, 0x7
    #Se extrae el bit en la posición 6 con una máscara con el número 20H y rotación
    andi t1, a1, 0x20
    srli t1, t1, 0x7
    #Se realiza el XOR
    xor t2, t1, t0
    #Se extrae el bit en la posición 5 con una máscara con el número 10H y rotación
    andi t1, a1, 0x10
    srli t1, t1, 0x4 
    #Se realiza el XOR
    xor t2, t2, t1
    #Se extrae el bit en la posición 5 con una máscara con el número 8H y rotación
    andi t1, a1, 0x8
    srli t1, t1, 0x3
    #Se realiza el XOR
    xor t2, t2, t1
    #Se mueve el resultado del XOR al MSB
    slli t2, t2, 0x7
    #Se elimina el LSB del valor semilla con una rotación
    srli t3, a1, 0x1
    #Se actualiza el valor semilla sumándole el resultado del XOR
    add a1, t3, t2
    #Se actualiza el conteo del contador y la dirección de memoria
    addi a3, a3, 0x1
    addi a2, a2, 0x4
    sw a1, 0(a2)
    #Se realiza un branch, si el conteo ya superó las 100 iteraciones se pasa al final
    blt a3, a4, lsfr

end:
    nop
    