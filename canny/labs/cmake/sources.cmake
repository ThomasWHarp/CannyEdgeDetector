add_lab("CannyImage")
#add_lab_solution("CannyImage" ${PROJECT_SOURCE_DIR}/solution.cu)
#set(sources ${PROJECT_SOURCE_DIR}/Otsus_Method_Sequential.cu ${PROJECT_SOURCE_DIR}/solution.cu)
#cuda_add_executable(CannyImage_Solution ${sources})
#target_link_libraries(CannyImage_Solution ${WBLIB} )

# Splitting out executables for my sanity

################################################################################
################################################################################
##
## LIBRARIES
##
################################################################################
################################################################################

################################################################################
# Filters
################################################################################
set( target_filters filters )
set( sources_filters
  ${PROJECT_SOURCE_DIR}/filters.cu
  )
cuda_add_library( ${target_filters} ${sources_filters} )

################################################################################
# Otsu's
################################################################################
set( target_otsu otsu )
set( sources_otsu
  ${PROJECT_SOURCE_DIR}/Otsus_Method_Sequential.cu
  )
cuda_add_library( ${target_otsu} ${sources_otsu} )

################################################################################
# nonmaxsupp
################################################################################
set( target_nms nms )
set( sources_nms
  ${PROJECT_SOURCE_DIR}/non_max_supp.cu
  )

cuda_add_library( ${target_nms} ${sources_nms} )

################################################################################
################################################################################
##
## EXECUTABLES
##
################################################################################
################################################################################

################################################################################
# Build serial executables
################################################################################
set( target_canny_serial CannyImage_Serial )

set( canny_serial_libs
  ${target_filters}
  ${target_otsu}
  ${target_nms}
  ${WBLIB} 
  )

set( canny_serial_sources
  ${sources_non_max_supp_serial}
  ${PROJECT_SOURCE_DIR}/solution_serial.cpp
  ) 

add_executable( ${target_canny_serial} ${canny_serial_sources} )
target_link_libraries( ${target_canny_serial} ${canny_serial_libs} ) 

################################################################################
# Build CUDA executables
################################################################################
set(target_canny_gpu CannyImage_Solution )

set( canny_gpu_libs
  ${target_filters}
  ${target_otsu}
  ${target_nms}
  ${WBLIB} 
  )

set(sources_gpu 
  ${PROJECT_SOURCE_DIR}/solution.cu
  )

cuda_add_executable(${target_canny_gpu} ${sources_gpu})
target_link_libraries( ${target_canny_gpu} ${canny_gpu_libs} ) 

