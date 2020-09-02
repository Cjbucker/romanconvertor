#Author: Chris Bucker

def fromRoman(romanNumber)
	romanNumerals = ["I", "V", "X", "L", "C", "D", "M"]
	finalValue = 0
	
	for letter in romanNumber.chars
		if !romanNumerals.include? letter
			raise TypeError
		end
	end
	mValue,index = fromLoop("M",romanNumber,1000)
	cValue,index = fromLoop("C",romanNumber,100,index)
	xValue,index = fromLoop("X",romanNumber,10,index)
	iValue,index = fromLoop("I",romanNumber,1,index)
	
	return finalValue = mValue + cValue + xValue + iValue
end

def fromLoop(requestedLetter, romanNumber, value, index = 0)
	endValue = 0
	halfNumeral = getHalf(requestedLetter)
	nextNumeral = getNext(requestedLetter)
	
	if romanNumber[index] != requestedLetter
		if romanNumber[index] == halfNumeral
			endValue = value*5
			index += 1
		else
			return endValue, index
		end
	end
	
	for letter in romanNumber.chars[index..romanNumber.chars.length-1]
		if letter == requestedLetter
			endValue += value
			index += 1
		elsif letter == halfNumeral
			endValue += value*3
			index += 1
			break
		elsif letter == nextNumeral
			endValue += value*8
			index += 1
			break
		end
	end
	
	return endValue, index
end

def toRoman(arabicNumber)
	romanNumber = ""
	
    if arabicNumber >= 4000 || arabicNumber <= 0
		raise RangeError
	end
	numberOfStartM = arabicNumber/1000.0
	numberOfStartC = (arabicNumber - numberOfStartM.floor()*1000.0) / 100.0
	numberOfStartX = (numberOfStartC*100.0 - numberOfStartC.floor()*100.0) / 10.0
	numberOfStartI = numberOfStartX*10.0 - numberOfStartX.floor()*10.0
	
	romanNumber = "M"*numberOfStartM.floor()
	romanNumber = romanNumber + checkToRoman(numberOfStartC, "C")
	romanNumber = romanNumber + checkToRoman(numberOfStartX, "X")
	romanNumber = romanNumber + checkToRoman(numberOfStartI, "I")
	
	return romanNumber
end

def checkToRoman(numberOfLetter, letter)
	numberOfLetter = numberOfLetter.floor()
	halfNumeral = getHalf(letter)
	nextNumeral = getNext(letter)
	
	if numberOfLetter <=3
		return letter*numberOfLetter
	end
	
	if numberOfLetter == 4
		return letter + halfNumeral
	elsif numberOfLetter == 9
		return letter + nextNumeral
	else 
		return halfNumeral + letter*(numberOfLetter-5)
	end
end

def getHalf(letter)
	halfNumeral = ""
	if letter == "C"
		halfNumeral = "D"
	elsif letter == "X"
		halfNumeral = "L"
	elsif letter == "I"
		halfNumeral = "V"
	end
	return halfNumeral
end

def getNext(letter)
	nextNumeral = ""
	if letter == "C"
		nextNumeral = "M"
	elsif letter == "X"
		nextNumeral = "C"
	elsif letter == "I"
		nextNumeral = "X"
	end
	return nextNumeral
end