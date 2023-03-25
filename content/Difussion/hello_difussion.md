---
title: "DDPM"
date: 2023-02-18T14:06:27+08:00
draft: true
---
Sources: denoising diffusion probabilistic models (DDPM; [Ho et al. 2020](https://arxiv.org/abs/2006.11239)).

$$q(\mathbf{x}_t|\mathbf{x}_{t-1})=\mathcal{N}(\mathbf{x}_t;\sqrt{1-\beta}\mathbf{x}_{t-1},\beta_t\mathbf{I})\qquad q(\mathbf{x}_{1:T}|\mathbf{x}_0)=\prod_{t=1}^T{q(\mathbf{x}_t|\mathbf{x}_{t-1})}$$

The data sample $\mathbf{x}_0$ gradually loses its distinguishable features as the step $t$ becomes larger. Eventually when $T\rightarrow \infty$, $\mathbf{x}_T$ is equivalent to an isotropic Gaussian distribution.

A nice property of the above process is that we can sample $\mathbf{x}_t$ at any arbitrary time step $t$ in a closed form using [reparameterization trick](https://lilianweng.github.io/posts/2018-08-12-vae/#reparameterization-trick). Let $\alpha_t=1-\beta_t$ and $\overline{\alpha}_t=\prod_{i=1}^t\alpha_i:$
$$\begin{align}
    \mathbf{x}_t & =\sqrt{\alpha_t}\mathbf{x}^{t-1}+\sqrt{1-\alpha_t}\epsilon_{t-1} & ; \text{where } \epsilon_{t-1}, \epsilon_{t-1}, \cdots \sim \mathcal{N}(\mathbf{0}, \mathbf{I}) \\
    & =\sqrt{\alpha_t\alpha_{t-1}}\mathbf{x}_{t-2}+\sqrt{1-\alpha_t\alpha_{t-1}}\overline{\epsilon}_{t-2} & ; \text{where } \overline{\epsilon}_{t-2} {\text{ merges two Gaussians (*)}}\ \\
    & = \cdots \\
    & = \sqrt{\overline{\alpha}_t}\mathbf{x}_0+\sqrt{1-\overline{\alpha}_t}\epsilon\\
    q(\mathbf{x}_t|\mathbf{x}_0) & =\mathcal{N}(\mathbf{x}_t;\sqrt{\overline{\alpha}_t}\mathbf{x}_0, (1-\overline{\alpha}_t)\mathbf{I})
    \end{align}    
$$

(*) Recall that when we merge two Gaussians with different variance, $\mathcal{N}(\mathbf{0},\sigma^2_1\mathbf{I})$ and 
$\mathcal{N}(\mathbf{0},\sigma^2_1\mathbf{I})$, the new distribution is $\mathcal{N}(0, (\sigma_1^2+\sigma_2^2)\mathbf{I})$. Here the merged standard deviation is $\sqrt{(1-\alpha_t)+\alpha_t(1-\alpha_{t-1})}=\sqrt{1-\alpha_t\alpha_{t-1}}$.

Usually, we can afford a larger update step when the sample gets noisier, so $\beta_1\lt\beta_2\le\cdots\beta_{T}$ and therefore $\overline{\alpha}_1\gt\overline{\alpha}_2\ge\cdots\overline{\alpha}_T$.

### Connection with stochastic gradient Langevin dynamics

Langevin dynamics is a concept from physics, developed for statistically modeling molecular systems. Combined with stochastic gradient descent, stochastic gradient Langevin dynamics [Welling & Teh 2011](https://www.stats.ox.ac.uk/~teh/research/compstats/WelTeh2011a.pdf) can produce samples from a probability density $p(\mathbf{x})$ using only the gradients $\nabla_{\mathbf{x}}\log{p(\mathbf{x})}$ in a Markov chain of updates:
$$\mathbf{x}_t=\mathbf{x}_{t-1}+\frac{\delta}{2}\nabla_{\mathbf{x}}\log{p(\mathbf{x}_{t-1})}+\sqrt{\delta}\epsilon_t,\quad \epsilon_t\sim\mathcal{N}(\mathbf{0},\mathbf{I})$$

where $\delta$ is the step size. When $T\rightarrow\infty, \epsilon\rightarrow 0$, $\mathbf{x}_t$ equals to the true probability density $p(\mathbf{x})$.

Compared to standard SGD, stochastic gradient Langevin dynamics injects Gaussian noise into the parameter updates to avoid collapses into local minima.

### Reverse diffusion process

If we can reverse the above process and sample from $q(\mathbf{x}_{t-1}|\mathbf{x}_t)$, we will be able to recreate the true sample from a Gaussian noise input, $\mathbf{x}_t\sim\mathcal{N}(\mathbf{0}, \mathbf{I})$. Note that if $\beta_t$ is a small enough, $q(\mathbf{x}_{t-1}|\mathbf{X}_t)$ will also be Gaussian. Unfortunately, we cannot easily estimate $q(\mathbf{x}_{t-1}|\mathbf{x}_t)$ because it needs to use the entire dataset and therefore we need to learn a model $p_\theta$ to approximate these conditional probabilities in order to run the reverse diffusion process.
$$p_\theta(\mathbf{x}_{0:T})=p(\mathbf{x}_T)\prod_{t=1}^T{p_\theta(\mathbf{x}_{t-1}|\mathbf{x}_t)} \quad p_\theta(\mathbf{x}_{t-1}|\mathbf{x}_t)=\mathcal{N}(\mathbf{x}_{t-1};\mu_\theta(\mathbf{x}_t, t),\Sigma_\theta(\mathbf{x}_t, t))$$

Using Bayes' relu, we have:

$$\begin{align}
    q(\mathbf{x}_{t-1}|\mathbf{x}_t,\mathbf{x}_0) & = q(\mathbf{x}_t|\mathbf{x}_{t-1},\mathbf{x}_0)\frac{q(\mathbf{x}_{t-1}|\mathbf{x}_0)}{q(\mathbf{x}_t|\mathbf{x}_0)}\\
    & \propto \exp{\left((-\frac{1}{2})(\frac{(\mathbf{x}_t-\sqrt{\alpha_t}\mathbf{x}_{t-1})^2}{\beta_t}+\frac{(\mathbf{x}_{t-1}-\sqrt{\overline{\alpha}_{t-1}}\mathbf{x}_0)^2}{1-\overline{\alpha
    }_{t-1}}+\frac{(\mathbf{x}_{t}-\sqrt{\overline{\alpha}_{t}}\mathbf{x}_0)^2}{1-\overline{\alpha
    }_{t}})\right)} \\
    &=\textcolor{red}{\mathbf{x}}
\end{align}
$$