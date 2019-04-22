import tensorflow as tf

test = {'chars': ['a','c','b','d','e','f','g','b']}  

hb = tf.feature_column.categorical_column_with_hash_bucket(
        key='chars',
        hash_bucket_size=5,
    )

column = tf.feature_column.embedding_column(hb, 3)
tensor1 = tf.feature_column.input_layer(test, [column])

sess.run(tf.global_variables_initializer())
sess.run(tf.tables_initializer())
print(sess.run([tensor]))

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    sess.run(tf.tables_initializer())
    print(sess.run([tensor]))


import tensorflow as tf

features = {'pets': ['dog','cat','rabbit','pig','mouse']}  

pets_f_c = tf.feature_column.categorical_column_with_vocabulary_list(
    'pets',
    ['cat','dog','rabbit','pig'], 
    dtype=tf.string, 
    default_value=-1)

column = tf.feature_column.embedding_column(pets_f_c, 3)
tensor = tf.feature_column.input_layer(features, [column])

sess.run(tf.global_variables_initializer())
sess.run(tf.tables_initializer())


with tf.Session() as session:
    session.run(tf.global_variables_initializer())
    session.run(tf.tables_initializer())
    print(session.run([tensor])