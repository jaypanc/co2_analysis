library(shiny)
library(ggplot2)


# data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
data <- read.csv("C:\\Users\\Jay\\Desktop\\co2_data.csv")

shinyUI(fluidPage(
  tabsetPanel(
    
    tabPanel("tab1",
             h1("Climate Change- the BIGGEST issue...",style="font-size:50px;font-weight:bolder;color:red"),
             
             h3("Earth's climate has changed over the past century. The atmosphere and
                oceans have warmed, sea levels have risen, and glaciers and ice sheets
                have decreased in size. The best available evidence indicates that greenhouse
                gas emissions from human activities are the main cause. Continuing increases in
                greenhouse gases will produce further warming and other changes in Earth's physical
                environment and ecosystems and Co2 is the largest contributor in the green house gas family"),
             br(),
             
             h3(uiOutput("survey1"),style="color:black"),
             br(),
             
             
             fluidRow(
               column(6,
                      img(src="https://www.climate.gov/sites/default/files/styles/full_width_620_original_image/public/2021-07/ClimateDashboard_Surface-temp_map_20210426_1400px.jpg?itok=LDYaAR7P",height=700,width=700),
               ),
               column(6,
                      img(src="https://ichef.bbci.co.uk/news/976/cpsprodpb/114E8/production/_121088807_berkeley_earth_land_and_ocean_v4-nc.png",height=700,width=700),
               )
             ),
             br(),
             
             h2("Impact of Climate Change:",style="font-size:40px;font-weight:bold"),
             h3(
               tags$ul(
                 tags$li("Extreme weather events are already more intense, threatening lives and livelihoods."),br(),
                 tags$li("With further warming, some regions could become uninhabitable, as farmland turns into desert.
                         In other regions, the opposite is happening, with extreme rainfall causing historic flooding
                         - as seen recently in China, Germany, Belgium and the Netherlands."),br(),
                 tags$li("People in poorer countries will suffer the most as they do not have the money to adapt to 
                         climate change. Many farms in developing countries already have to endure climates that are
                         too hot and this will only get worse."),br(),
                 
                 tags$li("Our oceans and its habitats are also under threat. The Great Barrier Reef in Australia, 
                         for example, has already lost half of its corals since 1995 due to warmer seas driven by 
                         climate change."),br(),
                 tags$li("Wildfires are becoming more frequent as climate change increases the risk of hot, dry weather."),br(),
                 tags$li(" And as frozen ground melts in places like Siberia, greenhouse gases trapped for centuries will 
                         be released into the atmosphere, worsening climate change."),br(),
                 tags$li("In a warmer world, animals will find it harder to find the food and water they need to live. For
                         example, polar bears could die out as the ice they rely on melts away, and elephants will struggle
                         to find the 150-300 litres of water a day they need."),br(),
             
                 tags$li("Scientists believe at least 550 species could be lost this century if action is not taken."),br(),
                   
               )),
               
             
               
               
                  
             h2("Effects of Climate Change",style="font-size:40px;font-weight:bold"),
             h3("If temperature rise cannot be kept within \\(1.5^{\\circ} C\\)",style="color:red"),
             br(),
             tags$h4(
             tags$ul(
               tags$li("The UK and Europe will be vulnerable to flooding caused by extreme rainfall"),br(),
               tags$li("Countries in the Middle East will experience extreme heatwaves and farmland could turn to desert"),br(),
               tags$li("Island nations in the Pacific region could disappear under rising seas"),br(),
               tags$li("Many African nations are likely to suffer droughts and food shortages"),br(),
               tags$li("Drought conditions are likely in the western US, while other areas will see more intense storms"),br(),
               tags$li("Australia is likely to suffer extremes of heat and drought"),br(),
               
             )),
             
             br(),
             
             
             
             
             
             
             
             ),
    
    tabPanel("tab2",
             sidebarLayout(
               sidebarPanel(titlePanel("Effects by Continents"),
                            selectInput("vary","select variable",choices = names(data)[3:dim(data)[2]]),
                            
                            sliderInput("date_input","select year range",min=1750,max=2020,value = c(1900,2020)),
               ),
               mainPanel(h3(textOutput("text_out_p1")),
                         plotOutput("plt"),
                         plotOutput("plt2"),
                         )
             ),
       
    ),
    
    tabPanel("tab3",
             
             sidebarLayout(
               sidebarPanel(titlePanel("effects on Countries"),
                            selectInput("varx2","select country",choices =unique(data$country),multiple = TRUE, selected = c("World") ),
                            selectInput("vary2","select feature to plot",choices = names(data)[3:dim(data)[2]]),
                            sliderInput("date_input2","select year range",min=1750,max=2020,value = c(1900,2020)),
               ),
               mainPanel(plotOutput("plt3",brush = "brush_plt3"),
                         dataTableOutput("data_info"),
                         
                        
               )
             ),
            
             ),
    
    tabPanel("tab4",
             sidebarLayout(
               sidebarPanel(
                         
                         selectInput("vary3","select feature",choices = names(data)[3:dim(data)[2]]),
                         sliderInput("date_input3","select year range",min=1750,max=2020,value = c(1900,2020)),
               ),
               mainPanel(
                         h3(textOutput("print1")),
                         plotOutput("plt4"),
                         h3(textOutput("print2")),
                         plotOutput("plt5"),
                         
                         
               )
             ),
             
             
             ),
    
 
    
    
  )  
  
  
)
)