1. Elegi 4 escenarios clave para eliminar la ambiguedad temporal

1. El solapamiento parcial posterior cubre una reserva nueva que empieza mientras la anterior sigue activa y termina después.

2. El intervalo contenido y el intervalo contenedor comprueban ambos sentidos de inclusión, que una prueba parcial no cubre.

3. El mismo horario en otra sala confirma que el conflicto depende de la sala y que los horarios iguales están permitidos en salas distintas.


2. El riesgo mas grave del repositorio es que la app flutter tiene una clave de supabase con el rol service_role y el readme confirma que esa clave se usa durante el desarrollo


3. ¿La regla protege la app real?
No por completo. El caso de uso rechaza solapamientos cuando se reserva desde el flujo normal, pero la consulta y la inserción son pasos separados: dos solicitudes simultáneas podrían pasar la consulta y guardar ambas. Además, la app tiene una clave service_role, que permite saltarse ese flujo y las políticas RLS.

