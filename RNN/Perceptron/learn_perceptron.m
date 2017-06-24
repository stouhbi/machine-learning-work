%% Learns the weights of a perceptron and displays the results.
function [w] = learn_perceptron(neg_examples_nobias,pos_examples_nobias,w_init,w_gen_feas)
%%
% Learns the weights of a perceptron for a 2-dimensional dataset and plots
% the perceptron at each iteration where an iteration is defined as one
% full pass through the data. If a generously feasible weight vector
% is provided then the visualization will also show the distance
% of the learned weight vectors to the generously feasible weight vector.
% Required Inputs:
%   neg_examples_nobias - The num_neg_examples x 2 matrix for the examples with target 0.
%       num_neg_examples is the number of examples for the negative class.
%   pos_examples_nobias - The num_pos_examples x 2 matrix for the examples with target 1.
%       num_pos_examples is the number of examples for the positive class.
%   w_init - A 3-dimensional initial weight vector. The last element is the bias.
%   w_gen_feas - A generously feasible weight vector.
% Returns:
%   w - The learned weight vector.
%%

%Bookkeeping
num_neg_examples = size(neg_examples_nobias,1);
num_pos_examples = size(pos_examples_nobias,1);
num_err_history = [];
w_dist_history = [];

%Here we add a column of ones to the examples in order to allow us to learn
%bias parameters.
neg_examples = [neg_examples_nobias,ones(num_neg_examples,1)];
pos_examples = [pos_examples_nobias,ones(num_pos_examples,1)];

%If weight vectors have not been provided, initialize them appropriately.
if (~exist('w_init','var') || isempty(w_init))
    w = randn(3,1);
else
    w = w_init;
end

if (~exist('w_gen_feas','var'))
    w_gen_feas = [];
end

%Find the data points that the perceptron has incorrectly classified
%and record the number of errors it makes.
iter = 0;
[mistakes0, mistakes1] = eval_perceptron(neg_examples,pos_examples,w);
num_errs = size(mistakes0,1) + size(mistakes1,1);
num_err_history(end+1) = num_errs;
fprintf('Number of errors in iteration %d:\t%d\n',iter,num_errs);
fprintf(['weights:\t', mat2str(w), '\n']);
plot_perceptron(neg_examples, pos_examples, mistakes0, mistakes1, num_err_history, w, w_dist_history);
key = input('<Press enter to continue, q to quit.>', 's');
if (key == 'q')
    return;
end

%If a generously feasible weight vector exists, record the distance
%to it from the initial weight vector.
if (length(w_gen_feas) ~= 0)
    w_dist_history(end+1) = norm(w - w_gen_feas);
end

%Iterate until the perceptron has correctly classified all points.
while (num_errs > 0)
    iter = iter + 1;

    %Update the weights of the perceptron.
    w = update_weights(neg_examples,pos_examples,w);

    %If a generously feasible weight vector exists, record the distance
    %to it from the current weight vector.
    if (length(w_gen_feas) ~= 0)
        w_dist_history(end+1) = norm(w - w_gen_feas);
    end

    %Find the data points that the perceptron has incorrectly classified.
    %and record the number of errors it makes.
    [mistakes0, mistakes1] = eval_perceptron(neg_examples,pos_examples,w);
    num_errs = size(mistakes0,1) + size(mistakes1,1);
    num_err_history(end+1) = num_errs;

    fprintf('Number of errors in iteration %d:\t%d\n',iter,num_errs);
    fprintf(['weights:\t', mat2str(w), '\n']);
    plot_perceptron(neg_examples, pos_examples, mistakes0, mistakes1, num_err_history, w, w_dist_history);
    key = input('<Press enter to continue, q to quit.>', 's');
    if (key == 'q')
        break;
    end
end

%WRITE THE CODE TO COMPLETE THIS FUNCTION
function [w] = update_weights(neg_examples, pos_examples, w_current)
%%
% Updates the weights of the perceptron for incorrectly classified points
% using the perceptron update algorithm. This function makes one sweep
% over the dataset.
% Inputs:
%   neg_examples - The num_neg_examples x 3 matrix for the examples with target 0.
%       num_neg_examples is the number of examples for the negative class.
%   pos_examples- The num_pos_examples x 3 matrix for the examples with target 1.
%       num_pos_examples is the number of examples for the positive class.
%   w_current - A 3-dimensional weight vector, the last element is the bias.
% Returns:
%   w - The weight vector after one pass through the dataset using the perceptron
%       learning rule.
%%
w = w_current;
num_neg_examples = size(neg_examples,1);
num_pos_examples = size(pos_examples,1);
for i=1:num_neg_examples
    this_case = neg_examples(i,:);
    x = this_case'; %Hint
    activation = this_case*w;
    if (activation >= 0)
        %YOUR CODE HERE
        %
@article{abdulhai_reinforcement_2003,
	title = {Reinforcement learning: Introduction to theory and potential for transport applications},
	volume = {30},
	issn = {0315-1468, 1208-6029},
	url = {http://www.nrcresearchpress.com/doi/abs/10.1139/l03-014},
	doi = {10.1139/l03-014},
	shorttitle = {Reinforcement learning},
	pages = {981--991},
	number = {6},
	journaltitle = {Canadian Journal of Civil Engineering},
	author = {Abdulhai, Baher and Kattan, Lina},
	urldate = {2015-05-18},
	date = {2003-12},
	langid = {english}
}

@article{hunt_scoot-traffic_1981,
	edition = {{LR}1014},
	title = {{SCOOT}-a traffic responsive method of coordinating signals},
	pages = {41},
	author = {Hunt, {PB} and Robertson, {DI} and Bretherton, {RD} and Winton, {RI}},
	date = {1981-01-01}
}

@article{sims_sydney_1980,
	title = {The Sydney coordinated adaptive traffic ({SCAT}) system philosophy and benefits},
	volume = {29},
	url = {http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=1622746},
	pages = {130--137},
	number = {2},
	journaltitle = {Vehicular Technology, {IEEE} Transactions on},
	author = {Sims, Arthur G. and Dobinson, K. W.},
	urldate = {2015-05-18},
	date = {1980}
}

@article{mirchandani_real-time_2001,
	title = {A real-time traffic signal control system: architecture, algorithms, and analysis},
	volume = {9},
	url = {http://www.sciencedirect.com/science/article/pii/S0968090X00000474},
	shorttitle = {A real-time traffic signal control system},
	pages = {415--432},
	number = {6},
	journaltitle = {Transportation Research Part C: Emerging Technologies},
	author = {Mirchandani, Pitu and Head, Larry},
	urldate = {2015-05-18},
	date = {2001}
}

@article{donati_hierarchical_1984,
	edition = {Vol 2},
	title = {A Hierarchical Decentralised Traffic Light Control System},
	pages = {11G/A--1},
	journaltitle = {Proceedings from {IFAC} 9th World Congress},
	author = {Donati, F and Mauro, G and Roncolini, G and Vallauri, M},
	date = {1984}
}

@article{arel_reinforcement_2010,
	title = {Reinforcement learning-based multi-agent system for network traffic signal control},
	volume = {4},
	issn = {1751956X},
	url = {http://digital-library.theiet.org/content/journals/10.1049/iet-its.2009.0070},
	doi = {10.1049/iet-its.2009.0070},
	pages = {128},
	number = {2},
	journaltitle = {{IET} Intelligent Transport Systems},
	author = {Arel, I. and Liu, C. and Urbanik, T. and Kohls, A.G.},
	urldate = {2015-05-19},
	date = {2010},
	langid = {english}
}

@article{robertson_transyt:_1969,
	location = {Road Res. Lab., London},
	edition = {{LR}253},
	title = {{TRANSYT}: A trafﬁc network study tool},
	issn = {0968-4093},
	pages = {37},
	author = {Robertson, D.I.},
	date = {1969-01-01}
}

@article{henry_prodyn_1984,
	location = {Proc. of the  {IFAC} Symposium, Baden-Baden},
	title = {{THE} {PRODYN} {REAL} {TIME} {TRAFFIC} {ALGORITHM}},
	pages = {305--310},
	author = {Henry, J J and Farges, J L and {TUFFAL}, J},
	date = {1984}
}

@article{gartner_opac:_1983,
	location = {Transportation Research Board:  Journal of the Transportation Research Board},
	title = {{OPAC}:  A  demand-responsive  strategy  for  traffic  signal  control},
	issn = {0361-1981},
	pages = {75--81},
	author = {Gartner, N.H.},
	date = {1983}
}

@article{di_taranto_utopia_1989,
	location = {Paris. ifac},
	edition = {In Proceedings of the {IFAC}-{IFIP}-{IFORS} Conference on Control, Computers, Communication in Transportation},
	title = {{UTOPIA}},
	author = {Di Taranto, M},
	date = {1989}
}

@article{head_hierarchical_1992,
	edition = {Transportation Research Record},
	title = {Hierarchical  framework  for  real-time  traffic control},
	pages = {82--88},
	author = {Head, K.L and Mirchandani, P.B and Sheppard, D},
	date = {1992}
}

@article{bazzan_opportunities_2009,
	title = {Opportunities for multiagent systems and multiagent reinforcement learning in traffic control},
	volume = {18},
	issn = {1387-2532},
	url = {http://dx.doi.org/10.1007/s10458-008-9062-9},
	doi = {10.1007/s10458-008-9062-9},
	pages = {342--375},
	number = {3},
	journaltitle = {Autonomous Agents and Multi-Agent Systems},
	author = {Bazzan, {AnaL}.C.},
	date = {2009},
	keywords = {Coordination of agents, Game-theory, Multiagent learning, Multiagent systems, Reinforcement learning, Traffic signal control}
}

@article{abdulhai_reinforcement_2003-1,
	title = {Reinforcement Learning for True Adaptive Traffic Signal Control},
	volume = {129},
	url = {http://dx.doi.org/10.1061/(ASCE)0733-947X(2003)129:3(278)},
	doi = {10.1061/(ASCE)0733-947X(2003)129:3(278)},
	pages = {278--285},
	number = {3},
	journaltitle = {Journal of Transportation Engineering},
	author = {Abdulhai, B and Pringle, R and Karakoulas, G},
	date = {2003}
}

@report{thorpe_vehicle_1997,
	title = {Vehicle Traffic Light Control Using {SARSA}},
	institution = {Online]. Available: citeseer.ist.psu.edu/thorpe97vehicle.html},
	author = {Thorpe, Thomas L.},
	date = {1997}
}

@book{bingham_reinforcement_2001,
	edition = {European Journal  of Operational Research},
	title = {Reinforcement Learning in Neurofuzzy Traffic Signal Control},
	volume = {131(2)},
	pagetotal = {232–241},
	author = {Bingham, Ella},
	date = {2001-06}
}

@inproceedings{de_oliveira_reinforcement_2006,
	title = {Reinforcement Learning based Control of Traffic Lights in Non-stationary Environments: A Case Study in a Microscopic Simulator.},
	url = {http://tr-sim.googlecode.com/svn/trunk/resources/reinforcementLearningTrafficLights.pdf},
	shorttitle = {Reinforcement Learning based Control of Traffic Lights in Non-stationary Environments},
	booktitle = {{EUMAS}},
	author = {de Oliveira, Denise and Bazzan, Ana {LC} and da Silva, Bruno Castro and Basso, Eduardo W. and Nunes, Luis and Rossetti, Rosaldo and de Oliveira, Eugénio and da Silva, Roberto and Lamb, Luis},
	urldate = {2015-05-21},
	date = {2006}
}

@report{el-tantawy_comprehensive_2011,
	title = {Comprehensive analysis of reinforcement learning methods and parameters for adaptive traffic signal control},
	author = {El-Tantawy, Samah and Abdulhai, Baher},
	date = {2011}
}

@article{brys_distributed_2014,
	title = {Distributed learning and multi-objectivity in traffic light control},
	volume = {26},
	pages = {65--83},
	number = {1},
	journaltitle = {Connection Science},
	author = {Brys, Tim and Pham, Tong T. and Taylor, Matthew E.},
	date = {2014}
}

@book{webster_traffic_1958,
	title = {Traffic Signal Settings},
	url = {https://books.google.co.ma/books?id=c9QOQ4jXK5cC},
	series = {Road research technical paper},
	publisher = {H.M. Stationery Office},
	author = {Webster, F.V.},
	date = {1958},
	lccn = {58004276}
}

@book{sutton_reinforcement_1998,
	title = {Reinforcement Learning: An Introduction},
	isbn = {9780262193986},
	url = {https://books.google.co.ma/books?id=CAFR6IBF4xYC},
	series = {A Bradford book},
	publisher = {Bradford Book},
	author = {Sutton, R.S. and Barto, A.G.},
	date = {1998},
	lccn = {97026416}
}prediction = 1
        w = w - this_case'
    end
end
for i=1:num_pos_examples
    this_case = pos_examples(i,:);
    x = this_case';
    activation = this_case*w;
    if (activation < 0)
        %YOUR CODE HERE
        %prediction = 0
        w = w + this_case'
    end
end

function [mistakes0, mistakes1] =  eval_perceptron(neg_examples, pos_examples, w)
%%
% Evaluates the perceptron using a given weight vector. Here, evaluation
% refers to finding the data points that the perceptron incorrectly classifies.
% Inputs:
%   neg_examples - The num_neg_examples x 3 matrix for the examples with target 0.
%       num_neg_examples is the number of examples for the negative class.
%   pos_examples- The num_pos_examples x 3 matrix for the examples with target 1.
%       num_pos_examples is the number of examples for the positive class.
%   w - A 3-dimensional weight vector, the last element is the bias.
% Returns:
%   mistakes0 - A vector containing the indices of the negative examples that have been
%       incorrectly classified as positive.
%   mistakes0 - A vector containing the indices of the positive examples that have been
%       incorrectly classified as negative.
%%
num_neg_examples = size(neg_examples,1);
num_pos_examples = size(pos_examples,1);
mistakes0 = [];
mistakes1 = [];
for i=1:num_neg_examples
    x = neg_examples(i,:)';
    activation = x'*w;
    if (activation >= 0)
        mistakes0 = [mistakes0;i];
    end
end
for i=1:num_pos_examples
    x = pos_examples(i,:)';
    activation = x'*w;
    if (activation < 0)
        mistakes1 = [mistakes1;i];
    end
end
