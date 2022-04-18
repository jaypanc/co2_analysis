library(shiny)
library(readr)
library(dplyr)
library(data.table)
library(ggplot2)
library(caret)
library(stringr)



shinyServer(function(input,output,session){
    
  
#######   getting data
  data <- read.csv("C:\\Users\\Jay\\Desktop\\co2_data.csv")

  
  
######   filtering data based on year input    
    gp <-reactive({
      data %>% filter(year>=input$date_input[1],year<=input$date_input[2],country %in% c("Asia","Europe","Africa","Antarctica","Oceania","North America","South America"))
    })
    

######    line plot based on selected values    
    output$plt <-renderPlot({

            # as we have used aes_string, all aesthetics must in string format
      ggplot(data = gp(),aes_string("year",input$vary,group="country",color="country"))+geom_line(size=1.3)
      
        })
   
######    bar plot based on selected values    
    output$plt2 <- renderPlot({
        
      # filtered_data <- gp()%>%group_by(country)%>% summarise(val = sum(input$vary))
      
        ggplot(data=gp(),aes_string("country",input$vary,fill="country"))+geom_bar(stat="identity")+
        labs(title = paste("Total ",input$vary," from ",input$date_input[1]," to ",input$date_input[2]))
      
    })
    
    
    output$text_out_p1 <- renderText({
      paste(input$vary," for continents from ",input$date_input[1]," to ",input$date_input[2])
    })
    

################################################################################        

###### get data 
    
    f_data <- reactive({
      data %>% filter(year>=input$date_input2[1],year<=input$date_input2[2],country %in% c(input$varx2))
    })
    

    output$plt3 <- renderPlot({
      ggplot(data = f_data(),aes_string("year",input$vary2,group="country",color="country"))+geom_line(size=1.3)+labs(title=input$varx2)+
        labs(y=paste(input$vary2),title = paste(as.character(input$vary2)," from ",input$date_input2[1]," to ",input$date_input2[2]))
    })
  
    output$data_info <- renderDataTable({
      req(input$brush_plt3)
      brushedPoints(f_data()%>%select(country,!!sym(input$vary2),year) ,input$brush_plt3,xvar="year",yvar=as.character(input$vary2))
    })
    

    
    
    
    # unique(data[grep("^[^asia]",ignore.case = TRUE,data$country),2])
    # unique(data$country[!like(data$country,"asia",ignore.case = TRUE)]) ##this works
    # data %>% filter(year>=1900,!grepl("World|Asia|Europe|Africa|Antarctica|Oceania|North America|South America",country,ignore.case = TRUE)) %>% select(country) ##this works
    
  
    
################################################################################    
    
    ## sym() to convert string into symbol ie sym("co2") => co2
    ## !! to write function call
    ## alternative is {{sym(input$vary3)}}
    
    polluted <- reactive({
      data %>% filter(year>=input$date_input3[1],year<=input$date_input3[2],!grepl("World|Asia|Europe|Africa|Antarctica|Oceania|North America|South America",country,ignore.case = TRUE))%>%
      group_by(country)%>% summarise(val = sum(!!sym(input$vary3))) %>% arrange(desc(val))
    })
    

   
    
    
    output$plt4 <- renderPlot({
      ggplot(data=polluted()[1:10,],aes_string("country","val",fill="country"))+geom_bar(stat = "identity")+
        labs(y=paste(input$vary3))
    })
    
    output$plt5 <- renderPlot({
      ggplot(data=last(polluted(),10),aes_string("country","val",fill="country"))+geom_bar(stat="identity")+
        labs(y=paste(input$vary3))
    })
    
    output$print1 <- renderText({
      paste("Countries emitting MOST", input$vary3," from ",input$date_input3[1]," to ",input$date_input3[2])
    })
    output$print2 <- renderText({
      paste("Countries emitting LEAST ", input$vary3," from ",input$date_input3[1]," to ",input$date_input3[2])
    })
    
    
    
#################################################################################
    
    
    output$survey1 <- renderUI({
      # withMathJax(helpText("$$\\alpha^2 1.2^{\\circ} C$$"))
      withMathJax(helpText("Human activities are estimated to have caused approximately 1.0C of global warming 
      above pre-industriallevels, with a likely range of \\(0.8^{\\circ} C\\) to \\(1.2^{\\circ} C\\).
      Global warming is likely to reach \\(1.5^{\\circ} C\\) between 2030 and 2052 if it continues to 
      increase at the current rate"))
    })
    
    
    
    
})