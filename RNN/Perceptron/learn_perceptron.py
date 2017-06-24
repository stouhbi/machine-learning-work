import numpy as np

def eval_perceptron(neg_examples, pos_examples, w):
    ##
    # Evaluates the perceptron using a given weight vector. Here, evaluation
    # refers to finding the data points that the perceptron incorrectly classifies.
    # Inputs:
    #   neg_examples - The num_neg_examples x 3 matrix for the examples with target 0.
    #       num_neg_examples is the number of examples for the negative class.
    #   pos_examples- The num_pos_examples x 3 matrix for the examples with target 1.
    #       num_pos_examples is the number of examples for the positive class.
    #   w - A 3-dimensional weight vector, the last element is the bias.
    # Returns:
    #   mistakes0 - A vector containing the indices of the negative examples that have been
    #       incorrectly classified as positive.
    #   mistakes0 - A vector containing the indices of the positive examples that have been
    #       incorrectly classified as negative.
    ##
    num_neg_examples = len(neg_examples)
    num_pos_examples = len(pos_examples)
    mistakes0 = []
    mistakes1 = []
    for i in range(1,num_neg_examples):
        x = neg_examples[i,:]
        activation = x*w
        if activation >= 0:
            mistakes0 = mistakes0.append(i)

    for i in range(1,num_neg_examples):
        x = pos_examples[i,:]
        activation = x*w
        if activation < 0:
            mistakes1 = mistakes1.append(i)

    return (mistakes0, mistakes1)
#WRITE THE CODE TO COMPLETE THIS FUNCTION
 def update_weights(neg_examples, pos_examples, w_current):
    ##
    # Updates the weights of the perceptron for incorrectly classified points
    # using the perceptron update algorithm. This function makes one sweep
    # over the dataset.
    # Inputs:
    #   neg_examples - The num_neg_examples x 3 matrix for the examples with target 0.
    #       num_neg_examples is the number of examples for the negative class.
    #   pos_examples- The num_pos_examples x 3 matrix for the examples with target 1.
    #       num_pos_examples is the number of examples for the positive class.
    #   w_current - A 3-dimensional weight vector, the last element is the bias.
    # Returns:
    #   w - The weight vector after one pass through the dataset using the perceptron
    #       learning rule.
    ##
    w = w_current;
    num_neg_examples = len(neg_examples)
    num_pos_examples = len(pos_examples)
    for i in range(1,num_neg_examples):
        this_case = neg_examples[i,:]
        x = this_case  #Hint
        activation = this_case*w
        if activation >= 0:
            #YOUR CODE HERE


    for i in range(1,num_pos_examples):
        this_case = pos_examples[i,:]
        x = this_case
        activation = this_case*w
        if activation < 0:
            #YOUR CODE HERE



## Learns the weights of a perceptron and displays the results.
def learn_perceptron(neg_examples_nobias,pos_examples_nobias,w_init,w_gen_feas):
    ##
    # Learns the weights of a perceptron for a 2-dimensional dataset and plots
    # the perceptron at each iteration where an iteration is defined as one
    # full pass through the data. If a generously feasible weight vector
    # is provided then the visualization will also show the distance
    # of the learned weight vectors to the generously feasible weight vector.
    # Required Inputs:
    #   neg_examples_nobias - The num_neg_examples x 2 matrix for the examples with target 0.
    #       num_neg_examples is the number of examples for the negative class.
    #   pos_examples_nobias - The num_pos_examples x 2 matrix for the examples with target 1.
    #       num_pos_examples is the number of examples for the positive class.
    #   w_init - A 3-dimensional initial weight vector. The last element is the bias.
    #   w_gen_feas - A generously feasible weight vector.
    # Returns:
    #   w - The learned weight vector.
    ##

    #Bookkeeping
    num_neg_examples = len(neg_examples_nobias);
    num_pos_examples = len(pos_examples_nobias);
    num_err_history = [];
    w_dist_history = [];

    #Here we add a column of ones to the examples in order to allow us to learn
    #bias parameters.
    neg_examples = [neg_examples_nobias,np.ones((num_neg_examples,1))];
    pos_examples = [pos_examples_nobias,np.ones((num_pos_examples,1))];

    #If weight vectors have not been provided, initialize them appropriately.
    #if (~exist('w_init','var') || isempty(w_init))
    if not w_init:
        w = np.random.rand(3,1)
    else:
        w = w_init;


    #if (~exist('w_gen_feas','var'))
    #    w_gen_feas = [];
    #end

    #Find the data points that the perceptron has incorrectly classified
    #and record the number of errors it makes.
    iter = 0;
    (mistakes0, mistakes1) = eval_perceptron(neg_examples,pos_examples,w);
    num_errs = len(mistakes0) + len(mistakes1);
    num_err_history(end+1) = num_errs;
    fprintf('Number of errors in iteration %d:\t%d\n',iter,num_errs);
    fprintf(['weights:\t', mat2str(w), '\n']);
    plot_perceptron(neg_examples, pos_examples, mistakes0, mistakes1, num_err_history, w, w_dist_history);
    key = input('<Press enter to continue, q to quit.>', 's');
    if (key == 'q')
        return;
    end

    #If a generously feasible weight vector exists, record the distance
    #to it from the initial weight vector.
    if length(w_gen_feas) ~= 0:
        w_dist_history(end+1) = norm(w - w_gen_feas);
    end

    #Iterate until the perceptron has correctly classified all points.
    while (num_errs > 0)
        iter = iter + 1;

        #Update the weights of the perceptron.
        w = update_weights(neg_examples,pos_examples,w);

        #If a generously feasible weight vector exists, record the distance
        #to it from the current weight vector.
        if (length(w_gen_feas) ~= 0)
            w_dist_history(end+1) = norm(w - w_gen_feas);
        end

        #Find the data points that the perceptron has incorrectly classified.
        #and record the number of errors it makes.
        (mistakes0, mistakes1) = eval_perceptron(neg_examples,pos_examples,w);
        num_errs = len(mistakes0) + len(mistakes1);
        num_err_history(end+1) = num_errs;

        fprintf('Number of errors in iteration %d:\t%d\n',iter,num_errs);
        fprintf(['weights:\t', mat2str(w), '\n']);
        plot_perceptron(neg_examples, pos_examples, mistakes0, mistakes1, num_err_history, w, w_dist_history);
        key = input('<Press enter to continue, q to quit.>', 's');
        if (key == 'q')
            break;
