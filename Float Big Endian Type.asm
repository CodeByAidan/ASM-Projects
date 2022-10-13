alloc(TypeName,256)
alloc(ByteSize,4)
alloc(ConvertRoutine,1024)
alloc(ConvertBackRoutine,1024)
alloc(UsesFloat,1)
 
 
TypeName:
db 'Float Big Endian',0
 
 
ByteSize:
dd 4

UsesFloat:
db 1
 
 
ConvertRoutine:
[64-bit]
xor eax,eax
mov eax,[rcx] //eax now contains the bytes 'input' pointed to
bswap eax //convert to big endian
ret
[/64-bit]

[32-bit]
push ebp
mov ebp,esp
mov eax,[ebp+8] //place the address that contains the bytes into eax
mov eax,[eax] //place the bytes into eax so it's handled as a normal 4 byte value
bswap eax
pop ebp
ret 4
[/32-bit]
 
 
ConvertBackRoutine:
[64-bit]
bswap ecx //convert the little endian input into a big endian input
mov [rdx],ecx //place the integer the 4 bytes pointed to by rdx
ret
[/64-bit]

[32-bit]
push ebp
mov ebp,esp
push eax
push ebx
mov eax,[ebp+8] //load the value into eax
mov ebx,[ebp+c] //load the address into ebx
bswap eax
 
mov [ebx],eax //write the value into the address
pop ebx
pop eax
pop ebp
ret 8
[/32-bit]
