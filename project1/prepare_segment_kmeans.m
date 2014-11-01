function [std_data_matrix, parsed_data] = prepare_segment_kmeans(file)
    pf = arffparser('read',file);
    data_struct = pf;
    %% preparing attributes
    centroid_col = pf.regioncentroidcol.values()';
    centroid_row = pf.regioncentroidrow.values()';
    region_pixel = pf.regionpixelcount.values()';
    short_line_d5 = pf.shortlinedensity5.values()';
    short_line_d2 = pf.shortlinedensity2.values()';
    vedge_mean = pf.vedgemean.values()';
    hedge_mean = pf.hedgemean.values()';
    hedgesd = pf.hedgesd.values()';
    intensity_mean = pf.intensitymean.values()';
    rawred_mean = pf.rawredmean.values()';
    raweblue_mean = pf.rawbluemean.values()';
    rawegreen_mean = pf.rawgreenmean.values()';
    exred_mean = pf.exredmean.values()';
    exblue_mean = pf.exbluemean.values()';
    exgreen_mean = pf.exgreenmean.values()';
    value_mean = pf.valuemean.values()';
    saturation_mean = pf.saturationmean.values()';
    hue_mean = pf.huemean.values()';

    %% Creating data matrix ignoring animal and type attributes.
    % animal does not provide information, even causing noise
    % type is in fact a classification so it will be used to
    % explain the created clusters
    data_matrix = [centroid_col, centroid_row, region_pixel, short_line_d5,short_line_d2,vedge_mean,hedge_mean ,hedgesd,intensity_mean,rawred_mean,raweblue_mean,rawegreen_mean,exred_mean,exblue_mean,exgreen_mean,value_mean,saturation_mean,hue_mean];
    std_data_matrix = standarizer(data_matrix);
    parsed_data = pf;
    
    
end