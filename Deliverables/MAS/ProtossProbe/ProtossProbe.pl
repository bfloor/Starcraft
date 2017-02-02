 :- dynamic
condition/1,
minerals/1,
gas/1,
builder/0,
mineralField/4,
constructionSite/3,
workerActivity/2,
self/2,
base/4,
unitAmount/2,
supply/2,
nexusPosition/2,
isBuilder/1,%% DIY believes, goals
vespeneGeyser/4,
probeStatus/3,
assimilator/1.

	% Indicates when agent is busy gathering
	busy :- condition(List), member(gathering, List).
	
	% The cost of declared buildings (for every new building add the cost here)
	cost("Protoss Pylon", 100, 0).
	cost("Protoss Nexus", 400, 0).
	cost("Protoss Gateway", 150, 0).
	cost("Protoss Assimilator", 150, 0).
	cost("Protoss Cybernetics Core", 200, 0).
							
	% default distance check				
	distance(X1,Y1,X2,Y2,D) :- D is sqrt((X2-X1)**2 + (Y2-Y1)**2).
				
	% Check if there is an assimilator available for mining
	enoughAssimilators :- aggregate_all(count, assimilator(_), Count),
			     Count > 0.


	% Check if probe should collect the gas
	shouldMineVespene :- 	aggregate_all(count, workerActivity(_,gatheringGas), Count),
			     	Count < 2,
			     	enoughAssimilators,
			     	not(builder).