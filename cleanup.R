cleanup <- function(){

    library(dplyr)

#Download and clean dataset from https://www.fueleconomy.gov/feg/download.shtml

    data <- read.csv("vehicles.csv", header=TRUE)
        

    for (i in 1:36987){
    
        city.in <- data[i,5:11]
        comb.in <- data[i,16:22]
        hwy.in <- data[i, 35:41]
        range.in <- data[i,c(53,54,56)]
        data$citympg[i] <- sum(city.in)/sum(comb.in!=0)
        data$combmpg[i] <- sum(comb.in)/sum(comb.in!=0)
        data$hwympg[i] <- sum(hwy.in)/sum(hwy.in!=0)
        data$avgRange[i] <- sum(range.in)/sum(range.in!=0)
    }

    data[data$phevComb!=0,]$combmpg <- data[data$phevComb!=0,]$phevComb
    data[data$phevComb!=0,]$citympg <- data[data$phevComb!=0,]$phevCity
    data[data$phevComb!=0,]$hwympg <- data[data$phevComb!=0,]$phevHwy
    
    data$VClass <- as.character(data$VClass)
    data$VClass[grep("pickup|truck",data$VClass, ignore.case=TRUE)] <- "Pickup"
    data$VClass[grep("station|wagon",data$VClass, ignore.case=TRUE)] <- "Wagon"
    data$VClass[grep("utility|special",data$VClass, ignore.case=TRUE)] <- "SUV"
    data$VClass[grep("van",data$VClass, ignore.case=TRUE)] <- "Minivan"
    data$VClass[grep("compact|small|two|Car",data$VClass, ignore.case=TRUE)] <- "Coupe/Sedan"
    data$VClass <- as.factor(data$VClass)
    
    data$fuelType <- as.character(data$fuelType)
    data$fuelType[grep("E85",data$fuelType, ignore.case=TRUE)] <- "Flex-Fuel"
    data$fuelType[grep("or|and|elect",data$fuelType, ignore.case=TRUE)] <- "Hybrid"
    data$fuelType[grep("CNG|natural gas|propane",data$fuelType, ignore.case=TRUE)] <- "Natural Gas"
    data$fuelType[grep("mid|Prem|reg", data$fuelType, ignore.case=TRUE)] <- "Gasoline"
    data$fuelType <- as.factor(data$fuelType)

    data$trans <- as.character(data$trany)
    data$trans[grep("auto", data$trany, ignore.case=TRUE)] <- "Automatic"
    data$trans[grep("front|2", data$trany, ignore.case=TRUE)] <- "Manual"
    data$trans <- as.factor(data$trans)
    
    data$drive <- as.character(data$drive)
    data$drive[grep("4|all", data$drive, ignore.case=TRUE)] <- "4WD"
    data$drive[grep("front|2", data$drive, ignore.case=TRUE)] <- "FWD"
    data$drive[grep("rear", data$drive, ignore.case=TRUE)] <- "RWD"
    data$drive <- as.factor(data$drive)
    
    data <- data[grep("Acura|Audi|Alfa|Dodge|Toyota|Subaru|Volk|Volvo|
                    bmw|cadi|chry|Nis|hyu|lex|maz|ply|rolls|linc|gmc|honda|
                    mitsu|jeep|buick|chev|ford|infini|merc|olds|pont|eagle|merce|saab|saturn
                    |isuzu|AM General|Geo|suz|land r|lot|pors|kia|saleen|daew|Renau|scion|peug|
                    jag|lambo|masera|aston|Bent|mini|mayb|merkur|hummer|fiat|ram|bugatt|shelby|smart|
                    tesla|pagani",data$make, ignore.case=TRUE),]


    data <- select(data, -c(modifiedOn, createdOn, c240bDscr, charge240b, c240Dscr, guzzler,
                            mfrCode, youSaveSpend,UHighwayA, UHighway, UCityA, UCity, mpgData, id,
                            highwayUF, highwayE, highwayCD, highwayA08U, highwayA08, highway08U,
                            highway08, ghgScoreA, ghgScore, fuelType1, combinedUF, combinedCD,
                            co2TailpipeGpm, co2TailpipeAGpm, co2A, co2, cityUF, cityE, cityCD, 
                            cityA08U, cityA08, city08U, city08, charge240, charge120, barrelsA08, 
                            barrels08, fuelType2, startStop, trans_dscr, comb08, comb08U, combA08,
                            combA08U, combE, engId, eng_dscr, feScore, fuelCost08, fuelCostA08,
                            evMotor, phevComb, phevCity, phevHwy, rangeCityA, rangeHwyA, rangeA, 
                            range, rangeCity, rangeHwy, lv2, lv4, pv2, pv4, hlv, hpv, 
                            phevBlended, tCharger, sCharger, atvType, trany))
    
    
    data$year <- as.numeric(data$year)
    data$citympg <- as.numeric(data$citympg)
    data$combmpg <- as.numeric(data$combmpg)
    data$hwympg <- as.numeric(data$hwympg)
    
    
    
    write.csv(data, "output.csv")
    
}        