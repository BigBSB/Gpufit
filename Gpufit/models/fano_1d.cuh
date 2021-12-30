#ifndef GPUFIT_FANO1D_CUH_INCLUDED
#define GPUFIT_FANO1D_CUH_INCLUDED

__device__ void calculate_fano1d(               // ... = function name
    REAL const * parameters,
    int const n_fits,
    int const n_points,
    REAL * value,
    REAL * derivative,
    int const point_index,
    int const fit_index,
    int const chunk_index,
    char * user_info,
    std::size_t const user_info_size)
{
        // indices

    //REAL * user_info_float = (REAL*) user_info;
    
    REAL const x = 0;

    if (!user_info_float)
    {
        x = point_index;
    }
    else if (user_info_size / sizeof(REAL) == n_points)
    {
        x = user_info_float[point_index];
    }
    else if (user_info_size / sizeof(REAL) > n_points)
    {
        int const chunk_begin = chunk_index * n_fits * n_points;
        int const fit_begin = fit_index * n_points;
        x = user_info_float[chunk_begin + fit_begin + point_index];
    }

        // parameters

    REAL const * p = parameters;

    ///////////////////////////// value //////////////////////////////
    value[point_index] = p[0]*(((x - p[1] + (p[2] / 2) * p[3]) * (x - p[1] + (p[2] / 2) * p[3])) /((x - p[1])*(x - p[1]) + (p[2] * p[2]) / 4) + p[4];                   // formula calculating fit model values

    /////////////////////////// derivative ///////////////////////////
    float * current_derivative = derivative + point_index;

    current_derivative[0 * n_points] = ... ;  // formula calculating derivative values with respect to parameters[0]
    current_derivative[1 * n_points] = ... ;  // formula calculating derivative values with respect to parameters[1]
    current_derivative[2 * n_points] = ... ;
    current_derivative[3 * n_points] = ... ;
    current_derivative[4 * n_points] = ... ;
}

#endif